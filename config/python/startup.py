# Add auto-completion and a stored history file of commands to your Python
# interactive interpreter. Requires Python 2.0+, readline. Autocomplete is
# bound to the Esc key by default (you can change it - see readline docs).
#
# Store the file in ~/.pystartup, and set an environment variable to point
# to it: "export PYTHONSTARTUP=~/.pystartup" in bash.

import sys
import os
import atexit
import signal
import readline
import rlcompleter

try:
    import requests
    from lxml import html
except:
    pass

historyPath = os.path.expanduser("~/.pyhistory")


def save_history(historyPath=historyPath):
    readline.write_history_file(historyPath)


if os.path.exists(historyPath):
    readline.read_history_file(historyPath)

atexit.register(save_history)

# use <Control-O> for complete
#readline.parse_and_bind('"\t": complete')

del historyPath


def save_html(content):
    with open('a.html', 'w') as f:
        f.write(content.encode('utf8'))

def writeListToPcap(pcap,pl):
    subprocess.run('rm', '-f', pcap)
    for p in pl:
        wrpcap(pcap,p,append=True)

def build3Hand4Wave(pl):
    fic=True if pl[0][TCP].sport >= 49152 else False
    syn=copy.deepcopy(pl[0]) if fic else copy.deepcopy(pl[1])
    syn_ack=copy.deepcopy(pl[1]) if fic else copy.deepcopy(pl[0])
    if syn.haslayer('Raw'):
        del syn[Raw]
    if syn_ack.haslayer('Raw'):
        del syn_ack[Raw]
    syn[TCP].flags='S'
    syn_ack[TCP].flags='SA'
    syn_ack[IP].len=None
    syn[IP].len=None
    ack=copy.deepcopy(syn)
    ack[TCP].flags='A'
    ack[TCP].seq=pl[0].seq
    ack[TCP].ack=pl[0].ack
    ack[IP].len=None
    syn_ack[TCP].seq=ack[TCP].ack-1
    syn_ack[TCP].ack=ack[TCP].seq
    syn[TCP].seq=syn_ack[TCP].ack-1
    syn[TCP].ack=syn_ack[TCP].seq
    pl.insert(0,ack)
    pl.insert(0,syn_ack)
    pl.insert(0,syn)
    finc=copy.deepcopy(syn)
    finc[TCP].flags='FA'
    l=pl[-1]
    finc[TCP].seq=l[TCP].ack
    finc[TCP].ack=l[TCP].seq+(l[IP].len-(l[IP].ihl<<2)-(l[TCP].dataofs<<2))
    finc[IP].len=None
    acks=copy.deepcopy(syn_ack)
    acks[TCP].flags='A'
    acks[TCP].seq=finc[TCP].ack
    acks[TCP].ack=finc[TCP].seq+1
    acks[IP].len=None
    fins=copy.deepcopy(syn_ack)
    fins[TCP].flags='FA'
    fins[TCP].seq=acks[TCP].ack
    fins[TCP].ack=acks[TCP].seq
    fins[IP].len=None
    ackc=copy.deepcopy(syn)
    ackc[TCP].flags='A'
    ackc[TCP].seq=fins[TCP].ack
    ackc[TCP].ack=fins[TCP].seq+1
    ackc[IP].len=None
    pl.append(finc)
    pl.append(acks)
    pl.append(fins)
    pl.append(ackc)


def insertContentToPacketlist(pl,index,load,direction=1):                       
    syn=pl[0]                                                                   
    syn_ack=pl[1]                                                               
    t_1=copy.deepcopy(pl[index-1])                                              
    t=copy.deepcopy(pl[index])                                                  
    t[Raw].load=load                                                            
    print(t[IP].ihl)                                                            
    print(t[TCP].dataofs)                                                       
    t[IP].len=(t[IP].ihl<<2)+(t[TCP].dataofs<<2)+len(t[Raw].load)               
    print(len(t[Raw].load))                                                     
    t1=copy.deepcopy(pl[index+1])                                               
    pl.insert(index,t)                                                          
    pl.insert(index+1,t1)                                                       
    i=index+1                                                                   
    pllen=len(pl)                                                               
    while i < pllen:                                                            
        c=pl[i]                                                                 
        j=i-1                                                                   
        while j >=0:                                                            
            if c[IP].src != pl[j][IP].src:                                      
                break                                                           
            j-=1                                                                
        if j==-1:                                                               
            return                                                              
        l=pl[j]                                                                 
        c[TCP].seq=l[TCP].ack                                                   
        ltf=l[TCP].flags                                                        
        if ltf=='FA' or ltf=='S' or ltf=='SA':                                  
            c[TCP].ack=l[TCP].seq+1                                             
        else:                                                                   
            c[TCP].ack=l[TCP].seq+(l[IP].len-(l[IP].ihl<<2)-(l[TCP].dataofs<<2))
        i+=1                                                                    

def isTelnet(pl):
    count=0
    for i,p in enumerate(pl):
        if hasattr(p,'load') and re.search(b'(\xff[\xec-\xff].){2,9}',p.load):
            #print(i)
            count+=1
    return count
