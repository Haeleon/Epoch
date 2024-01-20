shell.run("delete epoch/")
shell.run("wget https://raw.githubusercontent.com/Haeleon/Epoch/main/programs/install.lua epoch/install.lua")

-- Libraries/deps
shell.run("wget https://raw.githubusercontent.com/Haeleon/Epoch/main/programs/self.lua epoch/self.lua")
shell.run("wget https://raw.githubusercontent.com/Haeleon/Epoch/main/programs/self.lua epoch/build.lua")

-- Programs/commands
shell.run("wget https://raw.githubusercontent.com/Haeleon/Epoch/main/programs/fast_excavate.lua epoch/fast_excavate.lua")
shell.run("wget https://raw.githubusercontent.com/Haeleon/Epoch/main/programs/fill.lua epoch/fill.lua")