local function obfuscate(source, VarName, WaterMark)
    warn("Started obfuscating...")

    -- Default values if nil are provided
    VarName = VarName or "Taurus_"
    WaterMark = WaterMark or "WaterMark | Secure by Patrick"

    -- Ensure no nil values in watermark and variable name
    if type(WaterMark) ~= "string" then
        WaterMark = "WaterMark | Secure by Patrick"
    end
    if type(VarName) ~= "string" then
        VarName = "Taurus_"
    end

    local WM = "--[[" .. "\n" .. tostring(WaterMark) .. "\n" .. "]]--" .. "\n\n"

    local function randomString(length)
        -- Ensure length is valid
        if not length or length <= 0 then length = 10 end
        local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        local result = ""
        for i = 1, length do
            local randomIndex = math.random(1, #chars)
            result = result .. chars:sub(randomIndex, randomIndex)
        end
        return result
    end

    local function stringToBinary(str)
        local binaryString = {}
        for i = 1, #str do
            local byte = string.byte(str, i)
            local binary = ""
            while byte > 0 do
                binary = (byte % 2) .. binary
                byte = math.floor(byte / 2)
            end
            table.insert(binaryString, string.format("%.8d", binary))
        end
        return table.concat(binaryString, " ")
    end

    local function addBinary(number)
        local topic = {
            "Deobfuscate?", "Hello World!", "IronBrew Fork? Nope.",
            "PSU Fork? Nope.", "Touch some grass", "New update when?",
            "GhostyDuckyy", "Free obfuscator!", "E", randomString(math.random(50,150)),
        }

        local str = ""
        for i = 1, number do
            local randomTopic = topic[math.random(1, #topic)]
            local binaryStr = stringToBinary(randomTopic)
            str = str .. "local " .. VarName .. randomString(math.random(10, 12)) .. " = \"" .. binaryStr .. "\"; "
        end
        return str
    end

    local function fakeFunction()
        local x = randomString(math.random(5, 10))
        local y = randomString(math.random(5, 10))
        local z = x .. y
        return z
    end

    local function encryptString(str)
        local encrypted = ""
        for i = 1, #str do
            local byte = string.byte(str, i)
            encrypted = encrypted .. string.char(byte + math.random(1, 10))
        end
        return encrypted
    end

    local fakeKey = randomString(10)
    local fakeData = encryptString("This is a fake encrypted string.")

    -- Ensuring source is a string
    source = tostring(source or "print('Hello World!')")

    local sourceByte = ""
    for i = 1, #source do
        sourceByte = sourceByte .. "\"\\\"" .. string.byte(source, i) .. "\", "
    end

    local randomVar = {
        TableByte = randomString(math.random(15, 20)),
        LoadString = randomString(math.random(15, 20)),
        FakeVar = randomString(math.random(10, 15)),
    }

    local loadString = string.format([[
        local %s = loadstring(table.concat({"\\114", "\\101", "\\116", "\\117", "\\114", "\\110", "\\32", "\\102", "\\117", "\\110", "\\99", "\\116", "\\105", "\\111", "\\110", "\\40", "\\98", "\\121", "\\116", "\\101", "\\41", "\\10", "\\32", "\\32", "\\32", "\\32", "\\105", "\\102", "\\32", "\\116", "\\121", "\\112", "\\101", "\\111", "\\102", "\\40", "\\98", "\\121", "\\116", "\\101", "\\41", "\\32", "\\61", "\\61", "\\32", "\\34", "\\116", "\\97", "\\98", "\\108", "\\101", "\\34", "\\32", "\\116", "\\104", "\\101", "\\110", "\\10", "\\32", "\\32", "\\32", "\\32", "\\32", "\\32", "\\32", "\\32", "\\108", "\\111", "\\97", "\\97", "\\100", "\\115", "\\116", "\\114", "\\105", "\\110", "\\103", "\\40", "\\116", "\\97", "\\98", "\\108", "\\101", "\\46", "\\99", "\\111", "\\110", "\\99", "\\97", "\\116", "\\40", "\\98", "\\121", "\\116", "\\101", "\\41", "\\41", "\\40", "\\41", "\\10", "\\32", "\\32", "\\32", "\\32", "\\101", "\\108", "\\115", "\\101", "\\10", "\\32", "\\32", "\\32", "\\32", "\\32", "\\32", "\\32", "\\98", "\\121", "\\116", "\\101", "\\32", "\\61", "\\32", "\\123", "\\98", "\\121", "\\116", "\\101", "\\125", "\\10", "\\32", "\\32", "\\32", "\\32", "\\32", "\\32", "\\32", "\\32", "\\108", "\\111", "\\97", "\\97", "\\100", "\\115", "\\116", "\\114", "\\105", "\\110", "\\103", "\\40", "\\116", "\\97", "\\98", "\\108", "\\101", "\\46", "\\99", "\\111", "\\99", "\\97", "\\116", "\\40", "\\98", "\\121", "\\116", "\\101", "\\41", "\\41", "\\40", "\\41", "\\10", "\\32", "\\32", "\\32", "\\32", "\\101", "\\110", "\\100", "\\10", "\\101", "\\110", "\\100", "\\10"})())]], randomVar.LoadString)

    local encryptedCode = string.format([[
        local %s = "%s";
        print("Encrypted Fake Data: " .. %s)
    ]], randomVar.FakeVar, fakeData, randomVar.FakeVar)

    local fakeLayer1 = fakeFunction()
    local fakeLayer2 = fakeFunction()

    local obfuscatedCode = WM .. addBinary(math.random(30, 50)) .. loadString .. "; " ..
        addBinary(math.random(30, 50)) .. encryptedCode .. "; " .. fakeLayer1 .. "; " ..
        fakeLayer2 .. "; " .. sourceByte

    setclipboard(obfuscatedCode)
    warn("Obfuscation complete in " .. tostring(tick() - tick()) .. " seconds")

    return obfuscatedCode
end

return function(source, CustomVarName, WaterMark)
    task.spawn(function()
        obfuscate(source, CustomVarName, WaterMark)
    end)
end
