local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local Placing = false

local Pad = game.Workspace.NewHouses["HousePlot" .. Player.Name]
local ObjectCloneGlobal = nil

function CreateRegion3FromPart(Part)
    return Region3.new(Part.Position-(Part.Size/2),Part.Position+(Part.Size/2))
end

local PlacingPadRegion = CreateRegion3FromPart(Pad)

local function round(n)
	return math.floor(n + 0.5)
end

function isInRegion3(region, point)
    local relative = (point - region.CFrame.p) / region.Size
    return -0.5 <= relative.X and relative.X <= 0.5
       and -100 <= relative.Y and relative.Y <= 100
       and -0.5 <= relative.Z and relative.Z <= 0.5
end


script.Parent.MouseButton1Down:Connect(function()
	Placing = true
	local ObjectClone = game.Lighting.FurnitureItems[script.Parent.Name]:Clone()
	ObjectClone.Parent = Pad
	ObjectCloneGlobal = ObjectClone
	script.Parent.Parent.ObjectClone.Value = ObjectClone
	Mouse.Move:Connect(function()
		if Placing == true then
			if isInRegion3(PlacingPadRegion, Mouse.hit.p) then
				local x, y, z = script.Parent.Parent.ObjectClone.Value.PrimaryPart.CFrame:toEulerAnglesXYZ()
				local OldCFrameAngles = CFrame.fromEulerAnglesXYZ(x, y, z)
				script.Parent.Parent.ObjectClone.Value:SetPrimaryPartCFrame(CFrame.new(round(Mouse.hit.p.X), script.Parent.Parent.ObjectClone.Value.PrimaryPart.Position.Y, round(Mouse.hit.p.Z)) * OldCFrameAngles)
			end
		end
	end)
end)



Mouse.KeyDown:connect(function(key)
	if Placing == true then
		if key == "r" then
        	script.Parent.Parent.ObjectClone.Value:SetPrimaryPartCFrame(script.Parent.Parent.ObjectClone.Value.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(-45), 0))
		end
	end
end)

Mouse.Button1Down:Connect(function()
	if Placing == true then
		Placing = false
		ObjectCloneGlobal = nil
		script.Parent.Parent.ObjectClone.Value = nil
	end
end)




--game.ContextActionService:BindAction("keyPress", onKeyPress, true, Enum.KeyCode.R)