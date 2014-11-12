-- "extension.lua"
-- VLC Extension basic structure (template): ----------------

local info = {
    descriptor = {
        title        = "VLC Extension - Basic structure",
        version      = "1.0",
        author       = "Soare Daniel-Bogdan",
        url          = 'http://',
        shortdesc    = "short description",
        description  = "full description",
        capabilities = {"input-listener"}
    }
}

local embeddedSettings = {
    searchProviders = {
        {
            name    = "OpenSubtitles"
        }
    },
    languages = {
        {'alb', 'Albanian'},
        {'ara', 'Arabic'},
        {'arm', 'Armenian'},
        {'baq', 'Basque'},
        {'ben', 'Bengali'},
        {'bos', 'Bosnian'},
        {'bre', 'Breton'},
        {'bul', 'Bulgarian'},
        {'bur', 'Burmese'},
        {'cat', 'Catalan'},
        {'chi', 'Chinese'},
        {'hrv', 'Croatian'},
        {'cze', 'Czech'},
        {'dan', 'Danish'},
        {'dut', 'Dutch'},
        {'eng', 'English'},
        {'epo', 'Esperanto'},
        {'est', 'Estonian'},
        {'fin', 'Finnish'},
        {'fre', 'French'},
        {'glg', 'Galician'},
        {'geo', 'Georgian'},
        {'ger', 'German'},
        {'ell', 'Greek'},
        {'heb', 'Hebrew'},
        {'hin', 'Hindi'},
        {'hun', 'Hungarian'},
        {'ice', 'Icelandic'},
        {'ind', 'Indonesian'},
        {'ita', 'Italian'},
        {'jpn', 'Japanese'},
        {'kaz', 'Kazakh'},
        {'khm', 'Khmer'},
        {'kor', 'Korean'},
        {'lav', 'Latvian'},
        {'lit', 'Lithuanian'},
        {'ltz', 'Luxembourgish'},
        {'mac', 'Macedonian'},
        {'may', 'Malay'},
        {'mal', 'Malayalam'},
        {'mon', 'Mongolian'},
        {'nor', 'Norwegian'},
        {'oci', 'Occitan'},
        {'per', 'Persian'},
        {'pol', 'Polish'},
        {'por', 'Portuguese'},
        {'pob', 'Brazilian Portuguese'},
        {'rum', 'Romanian'},
        {'rus', 'Russian'},
        {'scc', 'Serbian'},
        {'sin', 'Sinhalese'},
        {'slo', 'Slovak'},
        {'slv', 'Slovenian'},
        {'spa', 'Spanish'},
        {'swa', 'Swahili'},
        {'swe', 'Swedish'},
        {'syr', 'Syriac'},
        {'tgl', 'Tagalog'},
        {'tel', 'Telugu'},
        {'tha', 'Thai'},
        {'tur', 'Turkish'},
        {'ukr', 'Ukrainian'},
        {'urd', 'Urdu'},
        {'vie', 'Vietnamese'}
    }

}

local searchProviders = {
    {
        name    = "OpenSubtitles"
    }
}







function descriptor()
   return info.descriptor
end
function activate()
   create_main_window()
end
function deactivate()
   -- what should be done on deactivation of extension
end
function close()
   -- function triggered on dialog box close event
   -- for example to deactivate extension on dialog box close:
   vlc.deactivate()
end

-- Custom part, Dialog box example: -------------------------


-- Example: w = d:add_label( "My Label", 2, 3, 4, 5 ) will create a label at row 3, col 2, with a relative width of 4, height of 5.
function create_main_window()

    -- ROW COUNTER --
    -- Declaration Block START --
    local rowCounter = {}
    rowCounter.__index = rowCounter
    function rowCounter:new()
        return setmetatable({c = 1}, rowCounter)
    end
    function rowCounter:reset()
        self.c = 1
    end
    function rowCounter:get()
        return self.c
    end
    function rowCounter:set(vc)
        self.c = vc
    end
    function rowCounter:getAndAdvance()
        local old_c = self.c
        self.c = self.c + 1
        return old_c
    end
    function rowCounter:getAndAdvanceBy(vcp)
        local old_c = self.c
        self.c = self.c + vcp
        return old_c
    end
    function rowCounter:advance()
        self.c = self.c + 1
    end
    -- Declaration Block STOP --

    local rCon = rowCounter:new()

    mw = vlc.dialog(info.descriptor.title)

    -- ROW 1
    lbl_prefLang     = mw:add_label('Prefered language:', 1, rCon:get(), 1, 1);
    sel_prefLang     = mw:add_dropdown(2, rCon:get(), 2, 1);
    btn_search       = mw:add_button('Search', close, 4, rCon:getAndAdvance(), 1, 1);

    -- ROW 2
    lbl_subsProvider = mw:add_label('Subtitle provider:', 1, rCon:get(), 1, 1);
    sel_subsProvider = mw:add_dropdown(2, rCon:getAndAdvance(), 2, 1);

    -- ROW 3
    lbl_title        = mw:add_label('Title: ', 1, rCon:get(), 1, 1);
    inp_title        = mw:add_text_input('', 2, rCon:getAndAdvance(), 2, 1);

    -- ROW 4
    lst_results = mw:add_list(1,rCon:getAndAdvance(),4,1)

    -- ROW 5
    btn_dl     = mw:add_button('Download!', close, 2, rCon:getAndAdvance(), 2, 1)

    -- ROW 6
    btn_help   = mw:add_button('Help!', close, 1, rCon:get(), 1, 1)
    btn_config = mw:add_button('Config...', close, 2, rCon:get(), 1, 1)
    btn_about  = mw:add_button('About!?', close, 3, rCon:get(), 1, 1)
    btn_close  = mw:add_button('Close', close, 4, rCon:get(), 1, 1)

    -- Populate fields

    -- Search Providers:
    sel_subsProvider:add_value('All', 0)
    for i, searchProvider in ipairs(searchProviders) do
        sel_subsProvider:add_value(searchProvider.name, i)
    end

    -- Prefered language
    for i, language in ipairs(embeddedSettings.languages) do
        sel_prefLang:add_value(language[2], i)
    end
end
