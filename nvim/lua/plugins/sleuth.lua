-- Automatic indentation detection
return {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- vim-sleuth works automatically, no configuration needed
        -- It will detect and set:
        -- - shiftwidth (indentation width)
        -- - expandtab (spaces vs tabs)
        -- - tabstop (tab width)
        
        -- Optional: You can still set fallback defaults
        vim.g.sleuth_automatic = 1

        -- Optional: Add some heuristics for specific filetypes
        vim.g.sleuth_gitcommit_heuristics = 0
        vim.g.sleuth_no_filetype_indent_on = 1
    end
} 
