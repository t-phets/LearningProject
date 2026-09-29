-- Shared/Components/StateResource.luau
--!strict
local StateResource = {}
StateResource.__index = StateResource

type StateResourceData = {
    Max: number,
    Current: number,
}

export type StateResource = typeof(setmetatable({} :: StateResourceData, StateResource))

function StateResource.new(maxValue: number): StateResource
    local self = setmetatable({
        Max = maxValue,
        Current = maxValue
    }, StateResource)
    return self
end

function StateResource.Reduce(self: StateResource, amount: number?)
    local reduction = amount or 1
    self.Current = math.max(0, self.Current - reduction)
end

function StateResource.Restore(self: StateResource, amount: number)
    self.Current = math.clamp(self.Current + amount, 0, self.Max)
end

function StateResource.HasEnough(self: StateResource, amount: number): boolean
    return self.Current >= amount
end

function StateResource.IsDepleted(self: StateResource): boolean
    return self.Current <= 0
end

return StateResource