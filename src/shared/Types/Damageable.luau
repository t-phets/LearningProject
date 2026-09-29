export type Damageable = {
    StateResource: {
        Reduce: (self: any, amount: number) -> (),
    },
}

return {}