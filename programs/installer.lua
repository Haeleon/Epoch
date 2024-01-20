-- Setup and installer
shell.run("cd /")
shell.run("delete epoch/")
shell.run("wget https://raw.githubusercontent.com/Haeleon/Epoch/main/programs/installer.lua epoch/installer.lua")

-- Libraries/deps
shell.run("wget https://raw.githubusercontent.com/Haeleon/Epoch/main/programs/self.lua epoch/self.lua")
shell.run("wget https://raw.githubusercontent.com/Haeleon/Epoch/main/programs/build.lua epoch/build.lua")

-- Programs/commands
shell.run("wget https://raw.githubusercontent.com/Haeleon/Epoch/main/programs/fast_excavate.lua epoch/fast_excavate.lua")
shell.run("wget https://raw.githubusercontent.com/Haeleon/Epoch/main/programs/fill.lua epoch/fill.lua")

print("\nInstalled successfully:")
shell.run("ls epoch")
print("\nEpoch has been installed!\nRun epoch/installer.lua to update. Enjoy!")