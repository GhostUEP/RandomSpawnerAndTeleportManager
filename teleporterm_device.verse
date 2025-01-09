using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Random }

teleporterm_device := class(creative_device):

    @editable
    Teleporters : [] teleporter_device = array{}

    # Any Activation method
    @editable ActivatorInputTrigger : input_trigger_device = input_trigger_device{}
    @editable ActivatorMutator : mutator_zone_device = mutator_zone_device{}
    @editable ActivatorVolume : volume_device = volume_device{}
    @editable ActivatorTrigger : trigger_device = trigger_device{}

    var CurrentTP : int = 0
    
    OnBegin<override>()<suspends>:void=
        # Any Activation method
        ActivatorInputTrigger.PressedEvent.Subscribe(OnInteracted)
        ActivatorMutator.AgentEntersEvent.Subscribe(OnInteracted)
        ActivatorVolume.AgentEntersEvent.Subscribe(OnInteracted)
        ActivatorTrigger.TriggeredEvent.Subscribe(OnInteractedTrigger)

    OnInteracted(A:agent):void=
        if (P:=player[A]):
            TeleportPlayer(P)

    OnInteractedTrigger(A:?agent):void=
        if (P:=player[A?]):
            TeleportPlayer(P)

    # Random teleport Player
    TeleportPlayer(P:player):void=
        var hasFoundTP : logic = false
        loop:
            if (not P.IsActive[]):
                Print("Player is not active, failed to teleport")
                return
            if (hasFoundTP?):
                Print("Player Teleported")
                break
            Print("Searching Teleporter")
            RandomTPNumber:=GetRandomInt(0, Teleporters.Length-1)
            if (RandomTPNumber <> CurrentTP, Teleporter:=Teleporters[RandomTPNumber]):
                Teleporter.Teleport(P)
                set CurrentTP = RandomTPNumber
                set hasFoundTP = true
                Print("Teleporter Found")

    # Random teleport Player async
    TeleportPlayerAsync(P:player)<suspends>:void=
        var hasFoundTP : logic = false
        loop:
            Sleep(0.1)
            if (not P.IsActive[]):
                Print("Player is not active, failed to teleport")
                return
            if (hasFoundTP?):
                Print("Player Teleported")
                break
            Print("Searching Teleporter")
            RandomTPNumber:=GetRandomInt(0, Teleporters.Length-1)
            if (RandomTPNumber <> CurrentTP, Teleporter:=Teleporters[RandomTPNumber]):
                Teleporter.Teleport(P)
                set CurrentTP = RandomTPNumber
                set hasFoundTP = true
                Print("Teleporter Found")
