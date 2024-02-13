return {
    {
        'akinsho/bufferline.nvim',
        version = "*",
        name = "bufferline",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup()
        end
    }
}
