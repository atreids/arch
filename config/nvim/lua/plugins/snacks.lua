return {
    "folke/snacks.nvim",
    opts = {
        picker = {
            hidden = true,
            sources = {
                files = {
                    hidden = true,
                },
            },
        },
        dashboard = {
            preset = {
                pick = function(cmd, opts)
                    return LazyVim.pick(cmd, opts)()
                end,
                header = [[
 __    __   ______   ______   __  __   __   __   __   ______    
/\ "-./  \ /\  __ \ /\  ___\ /\ \_\ \ /\ \ /\ "-.\ \ /\  ___\   
\ \ \-./\ \\ \  __ \\ \ \____\ \  __ \\ \ \\ \ \-.  \\ \  __\   
 \ \_\ \ \_\\ \_\ \_\\ \_____\\ \_\ \_\\ \_\\ \_\\"\_\\ \_____\ 
  \/_/  \/_/ \/_/\/_/ \/_____/ \/_/\/_/ \/_/ \/_/ \/_/ \/_____/ 
                                                                
             ______   ______  __   ______   __   ______         
            /\  ___\ /\  == \/\ \ /\  == \ /\ \ /\__  _\        
            \ \___  \\ \  _-/\ \ \\ \  __< \ \ \\/_/\ \/        
             \/\_____\\ \_\   \ \_\\ \_\ \_\\ \_\  \ \_\        
              \/_____/ \/_/    \/_/ \/_/ /_/ \/_/   \/_/        
                                                                
]],
       -- stylua: ignore
       ---@type snacks.dashboard.Item[]
       keys = {
         { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
         { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
         { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
         { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
         { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
         { icon = " ", key = "s", desc = "Restore Session", section = "session" },
         { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
         { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
         { icon = " ", key = "q", desc = "Quit", action = ":qa" },
       },
            },
        },
    },
}
