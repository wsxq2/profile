-- whichkey configuration
local wk = require("which-key")
wk.setup({
    preset = "classic",
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mo
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
            operators = false, -- adds help for operators like d, y, ...
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = false, -- default bindings on <c-w>
            nav = false, -- misc bindings to work with windows
            z = false, -- bindings for folds, spelling and others prefixed with z
            g = false, -- bindings for prefixed with g
        },
    },
})

wk.add({
    { "<leader>0", "<cmd>BufferLineGoToBuffer 10<cr>", desc = "jump to buffer 10" },
    { "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "jump to buffer 1" },
    { "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "jump to buffer 2" },
    { "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "jump to buffer 3" },
    { "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "jump to buffer 4" },
    { "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "jump to buffer 5" },
    { "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "jump to buffer 6" },
    { "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "jump to buffer 7" },
    { "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "jump to buffer 8" },
    { "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "jump to buffer 9" },
    { "<leader>F", "<cmd>Telescope git_files<cr>", desc = "search files (exclude submodules)" },
    { "<leader>G", "<cmd>Telescope grep_string<cr>", desc = "live grep cursor word" },
    { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "searcher buffers" },
    { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "search files (include submodules)" },
    { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "live grep" },
    { "<leader>h", "<cmd>Telescope help_tags<cr>", desc = "search vim manual" },
    { "<leader>i", "<cmd>Telescope jumplist<cr>", desc = "search jumplist" },
    { "<leader>j", "<cmd>Telescope emoji<cr>", desc = "search emoji" },
    { "<leader>k", "<cmd>Telescope colorscheme<cr>", desc = "colorscheme" },
    { "<leader>o", "<cmd>Telescope lsp_document_symbols<cr>", desc = "search symbols in file" },
    { "<leader>s", "<cmd>Telescope lsp_dynamic_workspace_symbols <cr>", desc = "search symbols in project" },
    { "<space>0", "<cmd>10wincmd w <cr>", desc = "jump to window 0" },
    { "<space>1", "<cmd>1wincmd w <cr>", desc = "jump to window 1" },
    { "<space>2", "<cmd>2wincmd w <cr>", desc = "jump to window 2" },
    { "<space>3", "<cmd>3wincmd w <cr>", desc = "jump to window 3" },
    { "<space>4", "<cmd>4wincmd w <cr>", desc = "jump to window 4" },
    { "<space>5", "<cmd>5wincmd w <cr>", desc = "jump to window 5" },
    { "<space>6", "<cmd>6wincmd w <cr>", desc = "jump to window 6" },
    { "<space>7", "<cmd>7wincmd w <cr>", desc = "jump to window 7" },
    { "<space>8", "<cmd>8wincmd w <cr>", desc = "jump to window 8" },
    { "<space>9", "<cmd>9wincmd w <cr>", desc = "jump to window 9" },
    { "<space>a", group = "misc" },
    { "<space>ad", "<cmd>call TrimWhitespace()<cr>", desc = "remove trailing space" },
    { "<space>at", "<Plug>Translate", desc = "translate current word" },
    { "<space>b", group = "buffer" },
    { "<space>bd", "<cmd>bdelete %<cr>", desc = "close current buffers" },
    { "<space>c", group = "ouroboros" },
    { "<space>cc", "<cmd>Ouroboros<cr>", desc = "open file in current window" },
    { "<space>ch", "<cmd>split | Ouroboros<cr>", desc = "open file in a horizontal split" },
    { "<space>cv", "<cmd>vsplit | Ouroboros<cr>", desc = "open file in a vertical split" },
    { "<space>f", group = "file" },
    { "<space>fo", "<cmd>NvimTreeFindFile<cr>", desc = "open file in dir" },
    { "<space>fs", "<cmd>w<cr>", desc = "save file" },
    { "<space>ft", "<cmd>NvimTreeToggle<cr>", desc = "toggle file tree" },
    { "<space>g", group = "git" },
    { "<space>gL", "<cmd>FloatermNew tig<cr>", desc = "log of project" },
    { "<space>ga", "<cmd>Git add -A<cr>", desc = "git stage all changes" },
    { "<space>gb", "<cmd>Git blame<cr>", desc = "git blame" },
    { "<space>gc", "<cmd>Git commit<cr>", desc = "git commit" },
    { "<space>gl", "<cmd>FloatermNew tig %<cr>", desc = "log of file" },
    { "<space>gm", "<cmd>GitMessenger<cr>", desc = "show git blame of current line" },
    { "<space>gp", "<cmd>Git push<cr>", desc = "git push" },
    { "<space>gs", "<cmd>FloatermNew tig status<cr>", desc = "git status" },
    { "<space>i", "<c-i>", desc = "go to newer jumplist" },
    { "<space>l", group = "language" },
    { "<space>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "code action" },
    { "<space>lc", "<cmd>Commentary<cr>", desc = "comment code" },
    { "<space>lf", "<cmd> lua vim.lsp.buf.format{ async = true }<cr>", desc = "format current buffer" },
    { "<space>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", desc = "lsp goto next" },
    { "<space>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", desc = "lsp goto prev" },
    { "<space>ln", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "rename" },
    { "<space>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "" },
    { "<space>lr", "<cmd>RunCode<cr>", desc = "run code" },
    { "<space>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "signature help" },
    { "<space>q", "<cmd>qa<cr>", desc = "close vim" },
    { "<space>s", group = "search" },
    { "<space>sP", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", desc = "search cursor word in project" },
    { "<space>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "search in current buffer" },
    { "<space>sg", "<cmd>Telescope git_status<cr>", desc = "search git status" },
    { "<space>sp", "<cmd>lua require('spectre').open()<cr>", desc = "search in project" },
    { "<space>t", group = "toggle" },
    { "<space>t7", "<cmd>let &cc = &cc == '' ? '75' : ''<cr>", desc = "highlight 75 line" },
    { "<space>t8", "<cmd>let &cc = &cc == '' ? '81' : ''<cr>", desc = "highlight 80 line" },
    { "<space>tb", "<cmd>let &tw = &tw == '0' ? '80' : '0'<cr>", desc = "automaticall break line at 80" },
    { "<space>th", "<cmd>noh<cr>", desc = "Stop the highlighting" },
    { "<space>tm", "<cmd>TableModeToggle<cr>", desc = "markdown table edit mode" },
    { "<space>tr", "<cmd>RsyncSaveSync toggle<cr>", desc = "toggle rsync on save" },
    { "<space>ts", "<cmd>set spell!<cr>", desc = "spell check" },
    { "<space>tt", "<cmd>set nocursorline<cr> <cmd>TransparentToggle<cr>", desc = "make background transparent" },
    { "<space>tw", "<cmd>set wrap!<cr>", desc = "wrap line" },
    { "<space>x", "<cmd>FloatermNew ipython<cr>", desc = "calculated" },
    { "K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "document" },
    { "c", group = "window" },
    { "cg", "<cmd>vsp<cr>", desc = "vertical split window" },
    { "ch", "<C-w>h", desc = "go to the window left" },
    { "cj", "<C-w>j", desc = "go to the window below" },
    { "ck", "<C-w>k", desc = "go to the window up" },
    { "cl", "<C-w>l", desc = "go to the window right" },
    { "cm", "<cmd>only<cr>", desc = "delete other window" },
    { "cn", "<cmd>AerialToggle!<cr>", desc = "toggle navigator" },
    { "cs", "<cmd>sp<cr>", desc = "horizontal split window" },
    { "cu", "<cmd>UndotreeToggle<cr>", desc = "open undo tree" },
    { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "go to declaration" },
    { "gT", "<cmd>BufferLineCyclePrev<cr>", desc = "prev tab" },
    { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "go to definition" },
    { "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "go to implementation" },
    { "gr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "go to reference" },
    { "gt", "<cmd>BufferLineCycleNext<cr>", desc = "next tab" },
    { "gw", "<cmd>Telescope diagnostics<cr>", desc = "diagnostics" },
    { "m", group = "bookmarks" },
    { "ma", "<cmd>Telescope bookmarks<cr>", desc = "search bookmarks" },
    { "md", "<cmd>lua require'bookmarks.list'.delete_on_virt()<cr>", desc = "Delete bookmark at virt text line" },
    { "mm", "<cmd>lua require'bookmarks'.add_bookmarks()<cr>", desc = "add bookmarks" },
    { "mn", "<cmd>lua require'bookmarks.list'.show_desc() <cr>", desc = "Show bookmark note" },
    { "q", "<cmd>q<cr>", desc = "close window" },
    { "{", "<cmd>AerialPrev<CR>", desc = "prev function" },
    { "}", "<cmd>AerialNext<CR>", desc = "next function" },
    {
      mode = { "v" },
      { "<space>lc", ":Commentary<cr>", desc = "comment code" },
      { "<space>s", group = "search" },
      { "<space>sp", "<cmd>lua require('spectre').open_visual()<cr>", desc = "search" },
      { "q", "<cmd>q<cr>", desc = "close window" },
      { "<space>lf", FormatFunction, desc = "format selection" },
    },
  })

-- 部分格式化，which-key 的设置方法有问题，似乎只是语法没有理解到位
-- https://vi.stackexchange.com/questions/36946/how-to-add-keymapping-for-lsp-code-formatting-in-visual-mode
function FormatFunction()
  vim.lsp.buf.format({
    async = true,
    range = {
      ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
      ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
    },
  })
end

vim.cmd("autocmd FileType sh lua BashLeaderX()")
function BashLeaderX()
  vim.api.nvim_set_keymap("n", "<leader>x", ":!chmod +x %<CR>", { noremap = false, silent = true })
end

vim.cmd("autocmd FileType markdown lua MarkdownLeaderX()")
function MarkdownLeaderX()
  vim.api.nvim_set_keymap("n", "<leader>x", ":MarkdownPreview<CR>", { noremap = false, silent = true })
end
