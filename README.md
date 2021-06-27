# Infrastructure as Code-workshop med Rett i prod 🚀

Denne workshopen gir en intro til infrastructure as code (IaC) med [terraform](https://www.terraform.io/).

## Før du starter

1. Installér `az` og `terraform`, f.eks. ved hjelp av [brew](https://brew.sh/): `brew install azure-cli terraform`. Sjekk at terraform versjonen din er minst `v1.0.0` ved å kjøre `terraform version`.

1. Det kan være lurt å installere en plugin i editoren din. VS Code har f.eks. extensionen "Hashicorp Terraform".

1. Skriv `az login` i terminalen for å logge inn i Azure. Her skal du logge inn med din Bekk-konto. Når det er gjort kan du bruke `az account show` til å sjekke at du er logget på, og at du bruker Nettskyprogrammet-subscriptionen.

1. Lag en fork av dette repoet (bruk knappen øverst til høyre), og lag en fork som ligger under din egen bruker. URL-en til det nye repoet blir da `https://github.com/<ditt-github-brukernavn>/iac-workshop`.

1. Gå til din fork av dette repoet. Her må du gjøre noen instillinger:
    1. Gå til `Actions` i menyen. Her skal du skru på GitHub Actions for ditt repo, slik at du får automatiserte bygg av frontend og backend. Byggene (GitHub kaller dette "workflows") vil bare kjøre dersom det er gjort endringer i hhv. `frontend/` eller `backend/` mappene i repoet.
    1. Når automatiserte bygg er skrudd på, må vi kjøre dem manuelt første gang. For hvert av byggene, trykk på "Run workflow" for å kjøre koden. Du trenger ikke laste ned artifaktene som lages av bygget, det gjøres automatisk når koden kjøres.
    1. Når frontend-bygget er ferdig, kan du se at artifakten er lastet opp på `https://github.com/<ditt-github-brukernavn>/iac-workshop/releases`.
    1. Backend-bygget legges i ditt private image-registry. Det bygde Docker-imaget kan du finne på `https://github.com/<ditt-github-brukernavn>?tab=packages>`.

1. Klon repoet med git. Pass på at du kloner din egen fork!

Du er nå klar til å starte!

## Terraform

Dette repoet har tre mapper: `frontend/`, `backend/` og `infrastructure/`. De to første inneholder koden for hhv. frontenden og backenden, og er med slik at du kan deploye en full app som faktisk fungerer. `infrastructure/` er den mappen som inneholder terraform-koden, og alle kommandoer og nye filer du lager skal ligge i denne mappen, men mindre noe annet er spesifisert.

I `infrastructure/`-mappen er det foreløpig ikke så mye:

* I `terraform.tf` beskrives hvilke *providers* du trenger, og konfigurasjonen av disse. En provider kan sammenliknes med et bibliotek/*library* fra andre programmeringsspråk. `azurerm` er en slik provider, som definerer ressurser i Azure du kan bruke og oversetter til riktige API-kall når du kjører koden.

* `main.tf` inneholder noen konstanter i `locals`-blokken, som kan brukes i programmet. Merk at `locals` kan defineres i en hvilken som helst terraform-fil, og være globalt tilgjengelige i alle andre filer. `main.tf` inneholder også en definisjon av ressursgruppen som skal opprettes.

* `variables.tf` inneholder variable som gis til terraform. `variable` likner litt på `locals`, men disse kan spesifiseres og overskrives når terraform kjøres, f.eks. ved å gi et ekstra argument på kommandolinjen. Det er litt tungvint å spesifisere variable på kommandolinjen, så vi kommer tilbake til hvordan vi kan gjøre dette enklere. `location` er den eneste variabelen som er definert foreløpig, og den har fått en default-verdi, så det er ikke noe vi trenger å gjøre noe med foreløpig.

* `hacks/`-mappen og `frontend-hacks.tf` inneholder et par skript og litt kode som brukes for å deploye frontenden når den endrer seg. Disse trenger du foreløpig ikke å tenke så mye på, vi kommer tilbake til dem senere.

Det var mye tekst, la oss gå videre til godsakene!

1. Før du kan provisjonere infrastruktur med terraform, må du initialisere providerne som er spesifisert i `terraform.tf`. Dette kan du gjøre ved å kjøre `terraform init` (husk å kjøre den fra `infrastructure/`-mappen!). Dette gjør ingen endringer på infrastrukturen, men oppretter bl.a. `.terraform`-mappen. `terraform init` må kjøres på nytt om du ønsker å installere eller oppgradere providers. **NB!** `.terraform` må ikke committes til git, da den kan inneholde sensitiv informasjon.

1. Når terraform er initialisert kan vi provisjonere infrastruktur ved å kjøre `terraform apply`. Først vil terraform gi en oversikt over endringene som blir gjort. Her opprettes en ressursgruppe i Azure og en random string, `id`, som brukes for å automatisk gi unike navn på ressursene vi skal opprette, f.eks. ressursgruppen. Skriv `yes` når terraform spør om du er sikker på om du vil fortsette.

1. Dersom alt gikk fint kan du finne navnet på ressursgruppen i en av de siste linjene i outputen:

    ```output
    azurerm_resource_group.rg: Creation complete after 1s [id=/subscriptions/9539bc24-8692-4fe2-871e-3733e84b1b73/resourceGroups/iac-workshop-xxxxxxxx]
    ```

    Det er den siste delen (`iac-workshop-xxxxxxxx`) vi er interessert i. Dette er navnet på ressursgruppen, og `xxxxxxxx` vil være den tilfeldige strengen som ble generert.

1. Gå til [Azure-portalen](https://portal.azure.com/), og sjekk at du kan finne ressursgruppen din. Den skal (foreløpig) være tom.

## Frontend

TODO: Set up storage account, without custom domain name, dns & and file deploy. Add variables to variables.tf, maybe use variables.auto.tfvars?

## Frontend deploy

TODO: Setup file deploy

## DNS

TODO: Setup DNS

## Backend

TODO: Setup backend

## Wrap-up

TODO: Extra tasks? Summarize