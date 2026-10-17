g_fonts = { name = "MS UI Gothic", file = nil, CharSet = SHIFTJIS_CHARSET }
g_fonts2 = { name = "Inconsolata", file = "DamekoiCustom Medium.PTF", CharSet = ANSI_CHARSET }
g_fontSize = { MsgSize = 12, NameSize = 16, LogSize = 12, selectSize = 12, inputSize = 12 }
g_fontSize2 = { MsgSize = 12, NameSize = 16, LogSize = 12, selectSize = 12, inputSize = 12 }
g_exampleName = "名前サンプル"
g_exampleText = "これは、サンプルテキスト表示です。\\nメッセージスピードとオートプレイの待ち時間、\\nウインドウ不透明度が反映されます。"
g_exampleName2 = "人名"
g_exampleText2 = [[这是一段示例文本。
文本会以这个速度展示。
1234567890 ABCDEFG!?]]
g_selectTextPos = { add_x = 0, add_y = 8 }
g_selectTextPos2 = { add_x = 0, add_y = 8 }
g_AnketoURL = nil
g_Savefonts = { name = "Inconsolata", size = 11, timesize = 11, nosize = 12 }
g_Savefonts2 = { name = "Inconsolata", size = 11, timesize = 10, nosize = 12 }

function SaveDataLabelTxt(p1_0, p1_1)
    local r1_0 = ""
    if p1_0 == g_DATAPAGEMAX then
        if p1_1 < 6 then
            r1_0 = " AUTO" .. tostring(p1_1)
        else
            r1_0 = "QUICK" .. tostring(p1_1 - 5)
        end
    else
        r1_0 = string.format("No.%02d", (p1_0 - 1) * 10 + p1_1)
    end
    return r1_0
end

g_saveComment = ""

function SaveDataTimeTxt(p2_0)
    if false then
        local r2_0 = { "年", "月", "日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", "日曜日", "午前", "午後" }
        local r2_1, r2_2 = p2_0, 0
        for r2_3, r2_4 in pairs(r2_0) do
            local r2_5, r2_6 = string.find(string.lower(r2_1), r2_4)
            if r2_5 ~= nil then
                local r2_7 = string.sub(r2_1, 1, r2_5 - 1)
                local r2_8 = string.sub(r2_1, r2_6 + 1)
                r2_2 = r2_2 + 1
                if r2_2 >= 3 then
                    r2_1 = r2_7 .. r2_8
                else
                    r2_1 = r2_7 .. "/" .. r2_8
                end
            end
        end
    end
    if false then
        p = 1
        q = 1
        count = 0
        for r2_9 = 1, 3 do
            local r2_10, r2_11 = string.find(string.lower(text), ":", q + 1)
            q = r2_11
            p = r2_10
            r2_10 = p
            if r2_10 == nil then
                break
            end
            count = count + 1
            if count >= 2 then
                text = string.sub(text, 1, p - 1)
                break
            end
        end
    end
    return text
end

g_NmsFonts = { name = "MS UI Gothic", size = 14 }
g_nmsTitleList = {}

function NmsMenuSetBookMarkAll(p3_0)
    if g_EnableNMS == false then
        return
    end
    local r3_0 = g_NmsData
    local r3_1 = {}
    r3_0.THP_BookMark = r3_1
    local r3_2 = 1
    r3_1 = 1
    local r3_3 = g_NmsData.MAX_THUMB
    for r3_4 = r3_1, r3_3 do
        if NmsMenuGetFlag(r3_4 - 1) then
            g_NmsData.THP_BookMark[r3_4] = p3_0
        else
            g_NmsData.THP_BookMark[r3_4] = 0
        end
        r3_2 = r3_2 + 1
    end
    PatchFlag1 = true
    PatchFlag2 = true
    local r3_5 = g_NmsData.MAX_THUMB_P1
    for r3_6 = 1, r3_5 do
        if PatchFlag1 then
            local r3_7 = NmsMenuGetFlag
            local r3_8 = g_NmsData.MAX_THUMB
            if r3_7(r3_6 + r3_8) then
                g_NmsData.THP_BookMark[r3_2] = p3_0
            else
                g_NmsData.THP_BookMark[r3_2] = 0
            end
        else
            g_NmsData.THP_BookMark[r3_2] = 0
        end
        r3_2 = r3_2 + 1
    end
    local r3_9 = g_NmsData.MAX_THUMB_P2
    for r3_10 = 1, r3_9 do
        if PatchFlag2 then
            local r3_11 = NmsMenuGetFlag
            local r3_12 = r3_10 + g_NmsData.MAX_THUMB
            local r3_13 = g_NmsData.MAX_THUMB_P1
            r3_12 = r3_12 + r3_13
            if r3_11(r3_12) then
                g_NmsData.THP_BookMark[r3_2] = p3_0
            else
                g_NmsData.THP_BookMark[r3_2] = 0
            end
        else
            g_NmsData.THP_BookMark[r3_2] = 0
        end
        r3_2 = r3_2 + 1
    end
    NmsMenuSaveBookMark()
end

function NmsMenuLoadBookMark()
    if g_EnableNMS == false then
        return
    end
    local r4_0 = cfunc.CSaveDataManager__lua_GetSavePath()
    r4_0 = r4_0 .. "nmsBookMark.dat"
    local r4_1 = io.open(r4_0, "r")
    if r4_1 == nil then
        NmsMenuSetBookMarkAll(0)
    else
        for r4_2 = 1, g_NmsData.MAX_THUMB + g_NmsData.MAX_THUMB_P1 + g_NmsData.MAX_THUMB_P2 do
            local r4_3 = g_NmsData.THP_BookMark
            local r4_4 = r4_1:read("*n")
            r4_3[r4_2] = r4_4
            r4_3 = g_NmsData.THP_BookMark
            if r4_3[r4_2] == nil then
                g_NmsData.THP_BookMark[r4_2] = 0
            end
        end
        r4_1:close()
    end
end

g_nmsBookMarkFlag = false

function NmsMenuSaveBookMark()
    if g_EnableNMS == false then
        return
    end
    if g_nmsBookMarkFlag then
        local r5_0 = cfunc.CSaveDataManager__lua_GetSavePath()
        r5_0 = r5_0 .. "nmsBookMark.dat"
        local r5_1 = io
        local r5_2 = r5_1.open(r5_0, "w")
        if r5_2 ~= nil then
            for r5_3 = 1, g_NmsData.MAX_THUMB + g_NmsData.MAX_THUMB_P1 + g_NmsData.MAX_THUMB_P2 do
                if g_NmsData.THP_BookMark[r5_3] == nil then
                    g_NmsData.THP_BookMark[r5_3] = 0
                end
                if #g_NmsData.THP_BookMark >= r5_3 then
                    r5_2:write(g_NmsData.THP_BookMark[r5_3] .. "\n")
                else
                    r5_2:write(0 .. "\n")
                    g_NmsData.THP_BookMark[r5_3] = 0
                end
            end
            r5_2:close()
        end
    end
end

function NmsMenuInitENP()
    if g_EnableNMS == false then
        return
    end
    g_NmsData.Slide = 0
    g_NmsData.List = {}
    g_NmsData.Act = -1
    g_NmsData.Param = 0
end

function getPKeyInfo()
    return "SEc073.ogg", 0, 10, 0.1
end
