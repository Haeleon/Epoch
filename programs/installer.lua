-- WIP new installer for Epoch with dependency management and command aliasing

local programURL = "https://raw.githubusercontent.com/Haeleon/Epoch/main/programs/"
local programs = {
    installer={
        args=nil,
        libdeps=nil,
    },
    update={
        args=nil,
        libdeps=nil,
    },
    fast_excavate={
        args={"#width", "<#length>"},
        libdeps={"self"},
    },
    fill={
        args={"#x1", "#y1", "#z1", "#x2", "#y2", "#z2", "'blockname'", "<'replace|hollow|frame|corners'>"},
        libdeps=nil,
    },
}

local libraryURL = "https://raw.githubusercontent.com/Haeleon/Epoch/main/programs/"
local libraries = {
    build={
        libdeps=nil,
    },
    self={
        libdeps=nil,
    }
}

shell.run("cd /")
shell.run("delete epoch/")

-- Get latest commit SHA for version checking
fs.open("/epoch/sha.txt", "w").write(textutils.unserializeJSON(http.get("https://api.github.com/repos/Haeleon/Epoch/commits/main").readAll()).commit.tree.sha)

for k, v in pairs(libraries) do
    shell.run("wget "..libraryURL..k..".lua epoch/"..k..".lua")
end

for k, v in pairs(programs) do
    shell.run("wget "..programURL..k..".lua epoch/"..k..".lua")

    shell.setAlias(k, "epoch/"..k..".lua")

    if v.args then
    shell.setCompletionFunction(
    "epoch/"..k..".lua",
        function(_, i, c)
            local n = i
            if #c < 1 then
                return {
                    table.concat(v.args, " ", n)
                }
            end
            if n < #v.args then
                return {" "}
            end
        end
    )

    end
end

local f = fs.open("startup.lua", "w")
f.seek("set", 0)
f.write("shell.run('/epoch/update.lua')")
f.close()