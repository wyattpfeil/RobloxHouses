local module = {}
local OldCFrameAngles = nil

function module.SizePartFromRight(PartToSize, AmountToSize)
	local x, y, z = PartToSize.CFrame:toEulerAnglesXYZ()
	if PartToSize.Orientation == Vector3.new(0,0,0) then
		OldCFrameAngles = CFrame.fromEulerAnglesXYZ(x, y, z)
	else
		OldCFrameAngles = CFrame.fromEulerAnglesXYZ(PartToSize.Orientation.X, PartToSize.Orientation.Y, PartToSize.Orientation.Z)
	end
	PartToSize.Size = Vector3.new(PartToSize.Size.X + AmountToSize, PartToSize.Size.Y, PartToSize.Size.Z)
	PartToSize.CFrame = CFrame.new(PartToSize.CFrame.X - AmountToSize/2, PartToSize.CFrame.Y, PartToSize.CFrame.Z) * OldCFrameAngles
end
function module.SizePartFromLeft(PartToSize, AmountToSize)
	local x, y, z = PartToSize.CFrame:toEulerAnglesXYZ()
	local OldCFrameAngles = CFrame.fromEulerAnglesXYZ(x, y, z)
	PartToSize.Size = Vector3.new(PartToSize.Size.X + AmountToSize, PartToSize.Size.Y, PartToSize.Size.Z)
	PartToSize.CFrame = CFrame.new(PartToSize.CFrame.X + AmountToSize/2, PartToSize.CFrame.Y, PartToSize.CFrame.Z) * OldCFrameAngles
end
function module.SizePartFromLeftZ(PartToSize, AmountToSize)
	local x, y, z = PartToSize.CFrame:toEulerAnglesXYZ()
	local OldCFrameAngles = CFrame.fromEulerAnglesXYZ(x, y, z)
	PartToSize.Size = Vector3.new(PartToSize.Size.X, PartToSize.Size.Y, PartToSize.Size.Z + AmountToSize)
	PartToSize.CFrame = CFrame.new(PartToSize.CFrame.X, PartToSize.CFrame.Y, PartToSize.CFrame.Z + AmountToSize/2) * OldCFrameAngles
end
function module.SizePartFromRightZ(PartToSize, AmountToSize)
	local x, y, z = PartToSize.CFrame:toEulerAnglesXYZ()
	local OldCFrameAngles = CFrame.fromEulerAnglesXYZ(x, y, z)
	PartToSize.Size = Vector3.new(PartToSize.Size.X, PartToSize.Size.Y, PartToSize.Size.Z + AmountToSize)
	PartToSize.CFrame = CFrame.new(PartToSize.CFrame.X, PartToSize.CFrame.Y, PartToSize.CFrame.Z - AmountToSize/2) * OldCFrameAngles
end
		
return module
