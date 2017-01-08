# oslometro.sh
Oslo metro depatures, now in bash!

## Usage:
```bash
./oslometro.sh [RUTER STOP ID]
```
To get the Ruter stop ID, go to [ruter.no](https://ruter.no/), press **See live departures**. Search for your metro stop, grab the 7-digit ID from the URL.

## Example
```bash
❯ ./oslometro.sh 3010370       

Departures heading towards sentrum

  L │ DESTINATION                   │ DEPATURW │ PLF
 ───│───────────────────────────────│──────────│─────
  4 │ Vestli                        │ 3 min    │  2
  5 │ Sognsvann                     │ 6 min    │  2
  5 │ Ringen via Storo              │ 13 min   │  2


Departures heading towards Sognsvann/Storo

  L │ DESTINATION                   │ DEPATURE │ PLF
 ───│───────────────────────────────│──────────│─────
  5 │ Ringen via Majorstuen         │ 4 min    │  1
  4 │ Bergkrystallen via Majorstuen │ 10 min   │  1
  5 │ Vestli via Majorstuen         │ 15:38    │  1
```
