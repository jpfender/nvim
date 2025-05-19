return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Obsidian Vault/*.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Obsidian Vault/*.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "work",
          path = "~/Documents/Obsidian Vault",
        },
      },
      ui = {
        enable = false,
      },
      mappings = {},
      picker = {
        name = "snacks.pick",
      },

      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs based on title and a random suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like 'My-new-note-ABCD', and therefore the file name 'My-new-note-ABCD.md'
        local file_name = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          file_name = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
          file_name = file_name .. "-"
        end
        for _ = 1, 4 do
          file_name = file_name .. string.char(math.random(65, 90))
        end
        return file_name
      end,

      --- Open external links in browser
      ---@param url string
      follow_url_func = function(url)
        vim.ui.open(url) -- need Neovim 0.10.0+
      end,

      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {
          today = function()
            return os.date("%A")
          end,
        },
      },

      daily_notes = {
        template = "daily.md",
      },

      -- Force Obsidian to foreground when opening a note
      open_app_foreground = true,
    },
    keys = {
      -- Daily notes
      { "<leader>nd", ":ObsidianToday<cr>", desc = "Open daily note" },
      { "<leader>nt", ":ObsidianTomorrow<cr>", desc = "Open tomorrow's daily note" },
      { "<leader>ny", ":ObsidianYesterday<cr>", desc = "Open yesterday's daily note" },

      -- Search/Pick
      { "<leader>nsb", ":ObsidianBacklinks<cr>", desc = "Backlinks" },
      { "<leader>nsd", ":ObsidianDailies<cr>", desc = "Last 5 dailies" },
      { "<leader>nsl", ":ObsidianLinks<cr>", desc = "Links" },
      { "<leader>nsn", ":ObsidianSearch<cr>", desc = "Note text" },
      { "<leader>nss", ":ObsidianQuickSwitch<cr>", desc = "Notes" },
      { "<leader>nst", ":ObsidianTags<cr>", desc = "Tags" },

      -- Misc
      { "<leader>nf", ":ObsidianFollowLink<cr>", desc = "Follow link" },
      { "<leader>nl", ":ObsidianLinkNew<cr>", mode = { "v", "x" }, desc = "Link new note from visual" },
      { "<leader>nn", ":ObsidianNew<cr>", desc = "New note" },
      { "<leader>no", ":ObsidianOpen<cr>", desc = "Open in Obsidian" },
      { "<leader>nx", ":ObsidianExtractNote<cr>", mode = { "v", "x" }, desc = "Extract text to new note" },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>n", group = "notes", mode = { "n", "v", "x" } },
        { "<leader>ns", group = "search" },
      },
    },
  },
}
