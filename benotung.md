
# Benotung von Tariq Al-Arashi

- 30% => Mitarbeit Praktikum (Anwesenheit + Testergebnisse): 1,00
- 50% => Projekt (Mittelwert der folgenden Einzelnoten): Dokumentation=2,00; Code Game=2,30; Backend=4,00; Pipeline=4,00
- 20% => Kreativität/Spielspaß: 3,00

Rechnerische Note: 2,44 => __Gegebene Note: 2,30__

Anmerkungen:

- Leider kein Highscore, der Userbezogen wäre, nur ein ganz allgemeiner. Der Einsatz einer Datenbank ist da auch schon ziemlich des Guten zuviel. Eine simple Textdatei hätte es da ja getan.
- Immerhin wurde nicht REDIS genommen und so etwas eigene Interpretation in die Vorgabe gesteckt.
- Es wurde aber kein Ingress für das REST Backend eingerichtet. So funktioniert das stateful Backend nicht im Cluster.
- Ingress Deployment funktioniert ebenfalls nicht (weder für Frontend noch für Backend)
- Backend wird über 'http://127.0.0.1:5000/highscore' angesprochen und kann damit nur mit Port-Forwarding funktinoieren.
- Gameloop gehört zur Spiellogik und hat daher im Controller eigentlich wenig zu suchen.
- UML Klassendiagramm ist in Dokumentation kaum zu lesen (unscharf, wieso nutzen Sie nicht ein skalierbares Format wie SVG oder höher aufgelöste?).
- Kein Highlevel Diagramm aus dem mal die Wechselwirkungen zwischen Client, Frontend und Backend sowie Datenbank hervorgehen würde.
