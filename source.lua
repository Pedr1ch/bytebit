
e=[[
-- Future projects
   -- BYTECODE INTERPRETER (MAYBE NOT)
   -- PREPR (Maybe YEAH?)

   FREE TO USE AND EDIT SOFTWARE, WITHOUT
   REQUIRING PERMISSION FROM THE OWNER

   Original Module by Pedrich#1561
   All Credits go to pedro86/phroaguz
   
   * INSTRUCTIONS *
   r_(module) == function returns the required copy of moduleScript module
   purefy_int_64_num(num: number) == returns the purified, floored, and pure copy of number num
   binary_rd_int(binary) == converts binary code binary to number
   
   And thats it lol the other funtions are self-explanatory.
]]
local function r_(module: ModuleScript)
	return require(module)
end
local lua_shift=(16777215*256)-1
local Content = {
	totalActions = 0 -- Total Actions
}
local function binary_rd_int(Binary: string)
	Binary = string.reverse(Binary)
	local Sum = 0
	for index = 1, #Binary do
		local Number = string.sub(Binary, index, index) == "1" and 1 or 0
		Sum += Number * math.pow(2, index - 1)
	end
	return Sum
end
local function purefy_int_64_num(num: number)
	local bit = bit32 or require("bit")
	return bit:bnot(num) - lua_shift
end
function Content.returnStringFromByteCode(Bytecode: string) --> Return String From Bytecode.
	
	local Better = Bytecode:gsub([[\]], " "):split(" ") --> Overrides Backslashes with Spaces
	-- * Uses the spaces to split each Byte
	local PackedBytecode = {} --> Creates a PackedBytecodes Table containing each letter.
	for i = 1, #Better do --> Loops set the letters into the table by translating each Byte using string.char
		if Better[i] == "" then
		else 
			local Char = string.char(tonumber(Better[i]))
			PackedBytecode[#PackedBytecode + 1] = tostring(Char)
		end
	end
	local String = ""
	for i = 1, #PackedBytecode do
		local Character = PackedBytecode[i]
		String = String .. Character
	end
	Content.totalActions += 1
	return String
end
function Content.returnByteCode(source: string)
	local array = {}
	for i = 1, #source do
		array[#array + 1] = source:sub(i, i)
	end
	local mainString = [[\]]
	for i = 1, #array do
		local value = array[i]
		if i == #array then
			mainString = mainString .. value:byte()
		else
			mainString = mainString .. value:byte() .. [[\]]
		end

	end
	Content.totalActions += 1
	return mainString
end
function Content.binaryToString(Bin: string)
	local function a(Binary: string)
		Binary = string.reverse(Binary)
		local Sum = 0
		for index = 1, #Binary do
			local Number = string.sub(Binary, index, index) == "1" and 1 or 0
			Sum += Number * math.pow(2, index - 1)
		end
		return Sum
	end
	local Binary = Bin
	local PackedBitCode = Binary:split(" ")
	local BitCode = ""
	for i = 1, (#PackedBitCode) do
		PackedBitCode[i] = string.char(a(PackedBitCode[i]))
	end
	for i = 1, (#PackedBitCode) do
		BitCode = BitCode .. PackedBitCode[i]
	end
	Content.totalActions += 1
	print(PackedBitCode)
	return BitCode
end
function Content.binaryToNumber(Binary: string)
	Binary = string.reverse(Binary)
	local Sum = 0
	local Number
	for i = 1, #Binary do
		Number = string.sub(Binary, i, i) == "1" and 1 or 0

		Sum = Sum + Number * math.pow(2, i - 1)
	end
	Content.totalActions += 1
	return Sum
end
function Content.GetCache()
	local Actions = Content.totalActions
	local Cache = bit32.bnot(Actions)-16777216*255 .. "kb"
	return Cache
end
local function bool_func_return(boolean, func)
	if boolean == true then
		return func()
	end
end
function Content.ByteCode_To_Json_int(bytecode: string, encodeJson: number, steps: number)
	local Steps=(steps+1)or(1)
	local HTTPService = game:GetService("HttpService")
	bool_func_return(bit32.btest(encodeJson), function()
		local success, returnedBytecode = xpcall(function() 
			return HTTPService:JSONEncode(bytecode)
		end, "error : ")
		bool_func_return(success, function()
			return returnedBytecode
		end)
	end)
	return string.format("[[main:%s]]", bytecode)
end
local z=[[THIS FUNCTION BELOW ME HAS NOT BEEN TESTED AND ITS BUGGY! FIXES ARE COMING AT V2]]
function Content.TranslateBinaryWithSpaces(binary: string)
	binary = Content.binaryToString(binary)
	for i = 1, binary:len() do
		bool_func_return(math.modf(i / 2), function()
			local o = binary:sub(i, i)
			local binarya = binary
			local newSpacedPair = binarya:sub(i - 1, i):gsub(binarya, (binarya:sub(1, 1):gsub(binarya:sub(1, 1), binarya:sub(1, 1) .. " ") ))
			binary:sub(i - 1, i):gsub(binary:sub(i - 1, i), binary:sub(i - 1, i) .. " ")
		end)
		if i == binary:len() then
			return binary
		end
	end 

end
function Content.EncryptTextWithPedrichCipher(source: string)
	local Main = source:reverse()
	local Bytecoded = Content.returnByteCode(source)
	print(Bytecoded)
	return Bytecoded
end
function Content.DecryptTextWithPedrichCipher(cipher: string)
	local DecryptedBytecode = Content.returnStringFromByteCode(cipher)
	local Unbytecoded = DecryptedBytecode
	return Unbytecoded
end
function Content.ReturnSizeFromBits(bits: string)
	local BitsValue = binary_rd_int(bits)
	return BitsValue .. " bits"
end
function Content.BitNShift(number: number, disposal: number, side: string)
	local bit = require("bit") or bit32
	if side == "left" then
		return bit:lshift(number, disposal)
	else
		return bit:rshift(number, disposal)
	end
end
function Content.AntiFloatingPointErrors(number: number)
	local numberFullyFloored = math.floor(purefy_int_64_num(number))
    return numberFullyFloored
end
function Content.hex_or_bit_to_int(int: number)
	local lua_shift_bor=bit32.bnot(int)
	if(lua_shift_bor/100<1024)then
		return((lua_shift_bor/100)*100).." bytes"
	elseif lua_shift_bor/100<1024 then
		local SteppedLua = lua_shift_bor/100
		return((lua_shift_bor/102400)*100).." Kilobytes"
	else
		return("hex_or_bit_to_int err: code 01: attempted to do HOBTI Arithmetic with a value above 1024576 Bytes.")
	end
	-- YEAH this has a lot of if statements, im sorry for the 4
	-- i just dont have enough skill to do it without much if if lol sniff sniff
end
function Content.hex_to_char(hex: number)
	local CharId = purefy_int_64_num(hex)
	local Char = string.char(CharId)
	return Char
end
local function setScriptEnvinronment() 
	getfenv().script = nil 
end
setScriptEnvinronment()
local env = getfenv()
local meta = {["by Pedrich"] = {setmetatable(Content, env)}}
print("loaded")
return meta["by Pedrich"][1]
