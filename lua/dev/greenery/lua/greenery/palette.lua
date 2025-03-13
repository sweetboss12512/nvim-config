local options = require("greenery.config").options

-- let s:hex.color0="#1f1f1f"
-- let s:hex.color1="#d4d4d4"
-- let s:hex.color2="#4c4c4c"
-- let s:hex.color3="#292929"
-- let s:hex.color4="#515151"
-- let s:hex.color5="#333333"
-- let s:hex.color6="#656565"
-- let s:hex.color7="#607053"
-- let s:hex.color8="#79896c"
-- let s:hex.color9="#6a6a6a"
-- let s:hex.color10="#d7ad66"
-- let s:hex.color11="#3d3d3d"
-- let s:hex.color12="#f2f2f2"
-- let s:hex.color13="#dedede"
-- let s:hex.color14="#424242"
-- let s:hex.color15="#4e5350"
-- let s:hex.color16="#e1f3e7"
-- let s:hex.color17="#ebc17a"
-- let s:hex.color18="#83a06c"
-- let s:hex.color19="#adc586"

local background = "#1f1f1f"

local variants = {
    main = {
        _nc = "#1f1f1f",
        base = "#1f1f1f",
        -- surface = "#1f1f1f",
        surface = "#2b2b2b", -- FIX
        overlay = "#2b2b2b",
        muted = "#6e6a86",
        subtle = "#4E5350",
        text = "#D4D4D4",
        -- text = "#E1F3E7",
        love = "#eb6f92",
        -- gold = "f6c177",
        gold = "#AFCAAF",
        -- rose = "ebbcba",
        rose = "#EBC17A",
        -- pine = "31748f",
        pine = "#83a06c",
        -- foam = "9ccfd8",
        foam = "#E1F3E7",
        types = "#C78547",
        -- iris = "c4a7e7",
        iris = "#769BAA",
        leaf = "#95b1ac",
        -- highlight_low = "#21202e",
        -- highlight_med = "#403d52",
        -- highlight_high = "#524f67",
        -- highlight_low = background,
        -- highlight_med = background,
        -- highlight_high = background,
        none = "NONE",
    },
    -- moon = {
    --     _nc = "#1f1d30",
    --     base = "#232136",
    --     surface = "#2a273f",
    --     overlay = "#393552",
    --     muted = "#6e6a86",
    --     subtle = "#908caa",
    --     text = "#e0def4",
    --     love = "#eb6f92",
    --     gold = "#f6c177",
    --     rose = "#ea9a97",
    --     pine = "#3e8fb0",
    --     foam = "#9ccfd8",
    --     iris = "#c4a7e7",
    --     leaf = "#95b1ac",
    --     highlight_low = "#2a283e",
    --     highlight_med = "#44415a",
    --     highlight_high = "#56526e",
    --     none = "NONE",
    -- },
    -- dawn = {
    --     _nc = "#f8f0e7",
    --     base = "#faf4ed",
    --     surface = "#fffaf3",
    --     overlay = "#f2e9e1",
    --     muted = "#9893a5",
    --     subtle = "#797593",
    --     text = "#464261",
    --     love = "#b4637a",
    --     gold = "#ea9d34",
    --     rose = "#d7827e",
    --     pine = "#286983",
    --     foam = "#56949f",
    --     iris = "#907aa9",
    --     leaf = "#6d8f89",
    --     highlight_low = "#f4ede8",
    --     highlight_med = "#dfdad9",
    --     highlight_high = "#cecacd",
    --     none = "NONE",
    -- },
}

if options.palette ~= nil and next(options.palette) then
    -- handle variant specific overrides
    for variant_name, override_palette in pairs(options.palette) do
        if variants[variant_name] then
            variants[variant_name] = vim.tbl_extend("force", variants[variant_name], override_palette or {})
        end
    end
end

-- if variants[options.variant] ~= nil then
--     return variants[options.variant]
-- end

-- return vim.o.background == "light" and variants.dawn or variants[options.dark_variant or "main"]
return variants.main
