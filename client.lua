RegisterCommand('car', function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local vehName = args[1] or 'adder'
    local vehHash = GetHashKey(vehName)

    if not IsModelAVehicle(vehHash) then
        notify('Invalid vehicle model: ' .. vehName, 'error')
        return
    end

    if not HasModelLoaded(vehHash) then
        RequestModel(vehHash)
        while not HasModelLoaded(vehHash) do
            Wait(0)
        end
    end  

    local playerCoords = GetEntityCoords(playerPed)
    local vehicle = CreateVehicle(vehHash, playerCoords.x, playerCoords.y, playerCoords.z, GetEntityHeading(playerPed), true, false)
    SetPedIntoVehicle(playerPed, vehicle, -1)
end)

TriggerEvent('chat:addSuggestion', '/car', 'Spawn a vehicle', {
    { name = 'model', help = 'Vehicle model name (default: adder)' }
})

function notify(message, type)
    lib.notify({
        title = 'Car Command',
        description = message,
        type = type or 'info'
    })
end
