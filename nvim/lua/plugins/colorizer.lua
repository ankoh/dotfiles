-- nvim-colorizer config

return { -- colorizer
    {
        "norcalli/nvim-colorizer.lua",
        event = { "BufRead", "BufNewFile" },
        config = function(_)
            require("colorizer").setup({
                '*'; -- Highlight all files, but customize the way they are highlighted
                css = { css = true; }; -- Enable parsing rgb(...) functions in css.
                html = { names = false; }; -- Disable parsing "names" like Blue or Gray
            }, {
                RGB      = true;         -- #RGB hex codes
                RRGGBB   = true;         -- #RRGGBB hex codes
                names    = false;        -- "Name" codes like Blue or Gray
                RRGGBBAA = false;        -- #RRGGBBAA hex codes
                rgb_fn   = false;        -- CSS rgb() and rgba() functions
                hsl_fn   = false;        -- CSS hsl() and hsla() functions
                css      = false;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn   = false;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
                mode     = 'background'; -- Set the display mode
            })

            -- Only attach to buffer after a delay and check file size
            vim.defer_fn(function()
                local buf = vim.api.nvim_get_current_buf()
                local bufname = vim.api.nvim_buf_get_name(buf)
                local ok, stats = pcall(vim.loop.fs_stat, bufname)
                
                -- Only attach if file is smaller than 50KB
                if ok and stats and stats.size < 50 * 1024 then
                    require("colorizer").attach_to_buffer(buf)
                end
            end, 500)  -- Delay by 500ms instead of 0
        end
    } }
