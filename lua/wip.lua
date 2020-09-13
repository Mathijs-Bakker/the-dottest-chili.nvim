local sln = require("solution")

local function is_cs_file(entry)
  local last_two_chars = string.len(entry) - 2
  if string.match(entry, ".cs", last_two_chars) then
    return true
  else
    return false
  end
end


local function traverse_path()
    local root = sln.omnisharp_sln
end

local function get_cs_files_in_directory()

  -- TODO: Use 'dir' on windows instead of 'ls'
  local files = io.popen("ls ~/Repositories/Sonitm/Net/SocialLibrary/Tests/FriendsTests")

  local csfiles = {}

  for entry in files:lines() do
    if is_cs_file(entry) then
      csfiles[#csfiles + 1] = entry
    end
  end

  return csfiles
end

function is_valid_testfile(file)
  local f = os.getenv("HOME") .. "/Repositories/Sonitm/Net/SocialLibrary/Tests/FriendsTests/FriendTests.cs"

  local file = io.open(file, "r")
  local contents = file:read("*all")
  file:close()

  if string.match(contents, "using NUnit.Framework;") then
    return true
  else
    return false
  end
end

local cmd = "dotnet test ~/Repositories/Sonitm/Net/SocialLibrary"

function runtest()
  local csfiles = get_cs_files_in_directory()
  local tests = get_test_files(csfiles)
end

return {
  runtest = runtest
}