# mta-ghost

A simple script for [Multi Theft Auto: San Andreas](mtasa.com), which enables players to
temporarily disable their vehicle collisions to pass through other vehicles, objects and so on.

## Use

To use the script, hold 'x' on the keyboard while driving a vehicle. That's all!
The main use is to play around in freeroam. Perhaps it would be also useful while making maps.

# Problems

The biggest problem with turning all vehicle collisions off is that it moves upwards all the time,
so to avoid that, the vehicle's velocity in Z direction is saved while activating ghost and applied
for all of its duration. It makes it behave unexpectedly sometimes, but may be used as a feature.
