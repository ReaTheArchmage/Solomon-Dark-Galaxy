Title: Solomon
Subtitle: Dark Galaxy

Briefing:
A dark sci-fi adventure in an abandoned galaxy. Explore space with your ship, scavange old relays, fighting rogue bots and other scavengers.

Inspo/references:
Halo, Dead Space, Warframe, EVE Online, Fallout

Pillars:
Space, Relays, Solitary, Combat

Core Loop:
Find a relay, clear it, return

Core Mechanics:

CCC:

    Switch between omnidirectional vehicle navigation and traditional FPS character control.
    (e.g. Warframes Railjack / Halo FPS pov)

Spaceship control:

    - Omnidirectional movement with no gravity
    - Sprint with recharging cap
    - Hypertravel to a known location

Character control:

    - First person humanoid movement with gravity
    - Antigravity buffered jump (halo jump)
    - Recharging jetpacks
    - Recharging sprint

Realtime combat:
    (combat is symetrical between player and enemies)

    Damage stats:
    - Base damage
    - Critical chance
    - Critical damage
    - Status chance

    Physical stats:

    - Firearms:
        - auto / semi
        - reload speed
        - magazine capacity
        - fire rate
        - recoil
    
    - Melee:
        - attack speed
        - attack range

    Firearms:
    - Raycast weapons:
        - damage stats
        - physical stats

    - AOE weapons:
        - damage stats
        - physical stats + (
            - area range
            - damage repetition
        )

    Melee:
    - Gun whipping:
        - damage stats
        - rate

    - Blade weapons
        - damage stats
        - physical stats

    Status Effects (on weapon damage):
    - Stun
        Temporarily unable to attack or move.
    - DOT:
        Stunned.
        Takes damage over time.
    
    - Defect:
        Temporarily attacks its allies.
    
    - Ragdoll:
        Stunned.
        Skeleton is treated as a physic body with no animation.

Enemy AI
    (Implements all combat capabilities)
    (Implements navigation agent)
    
    State machine:
        
        - Patrol:
            Follows precalculated path, avoids obstacles. 
            
        - Attack:
            - Shoot:
                If the target is in sight, attack it. Keeps focus on target.

            - Follow:
                Tries to reach the target and attack with melee.

        - Stunned

        - Ragdolled

Recap:
Player starts the game in their spaceship, which they procede to drive. After a short while, interest points (relays) should start appearing clearly. When entering relays commands will switch to first person character, with combat system. Loot the relay.
 