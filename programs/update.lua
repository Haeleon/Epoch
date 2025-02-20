local data = textutils.unserializeJSON(http.get("https://api.github.com/repos/Haeleon/Epoch/commits/main").readAll()).commit.tree.sha
local versionfile = fs.open("/epoch/sha.txt", "r").readAll()

if versionfile ~= data then
    shell.run("wget run https://epoch.madefor.cc")
end