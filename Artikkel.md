# Artikkel - Putt AI'en i en sandkasse!

Det er ikke lett å holde hodet kaldt når verden rundt deg stormer. Dette tror jeg mange har kjent og følt på i det siste. Selv er jeg skeptisk av natur, og i det siste har jeg ikke klart å slippe tankene rundt hvordan kollegaene og alle rundt meg tar i bruk AI-verktøy. Jeg elsker teknologi og liker å utforske, men samtidig vil jeg ha kontroll og være klar over konsekvensene. Jeg putter derfor AI-verktøyene i egne sandkasser, eller egne isolerte miljøer om du vil, og mener du bør vurdere å gjøre det samme.

## Jimmy hopper på AI-bølgen

Si hei til Jimmy! Jimmy er en fiktiv EDB-konsulent, med mange års erfaring innen IT-bransjen. Jimmy har hatt datamaskinen sin i flere år nå, og har brukt den flittig i både jobb og på privaten. På datamaskinen sin har han familiealbum fra tidligere sommer- og juleferier. Hemmeligheter og API-nøkler i diverse konfigurasjonsfiler her og der. Arkiverte konfidensielle prosjekter fra tidligere oppdrag. Passordhåndteringsprogramvare, med tilhørede terminal-utvidelse. Kort fortalt kan man vel si at Jimmy har brukt og satt opp datamaskinen sin slik mange av oss også gjør.

Jimmy er klar for nye eventyr, og nå er det AI som står for tur. Sammen med seg har han nyutdannede og fiktive Dory. Hun kommer rett fra studie, og har bare akkurat rukket å sette opp datamaskinen sin før Jimmy spør om hun ville være med å undersøke AI-verktøy. Det vil hun selvsagt. Hun er jo klar for det, hun har jo tross alt brukt mye AI under studietiden sin. I tillegg er hun akkurat ferdig med å konfigurere og sette opp mye av det hun så på som nødvendig i hverdagen, blant annet Github-tokens og 1Password-credentials i konfigurasjonsfiler, for å unngå å logge på disse tjenestene hele tiden.

Jimmy og Dory er klar for AI. I følge kollegaene sine er det bare å sjekke ut siste skrik av AI-modeller og -leverandører, og følge installasjonsinstruksjonene. "Bare last ned og installer, og så er du i gang!" forteller ivrige kollegaer og resten av Internett. Det høres jo lett ut. De søker litt rundt og finner fort OpenCode, med ufattelige 130k stjerner på Github! Dette må jo være bra og trygt siden så mange anbefaler og liker det. Installasjonen ser også rimelig rett fram ut:

```console
$ curl -fsSL https://opencode.ai/install | bash
```

Lett som en plett. Copy. Paste. Enter. Bam. AI-verktøy installert og klart! Neste steg blir å finne et passende sted å teste ut dette verktøyet. Jimmy navigerer seg inn i Diverse-mappen sin, og lister ut innholdet for å se hva som befinner seg der.

```console
$ cd Diverse
$ ls

Konfidensiell_kunde_1
Konfidensiell_kunde_2
Privat
Test_prosjekt
Top_secret_stuff
```

"Hm, hva er det som befinner seg inne i Privat-mappen igjen?", tenker Jimmy. Han navigerer seg inn dit og lister ut innholdet også her.

```console
$ cd privat
$ ls

backup_github_tokens.txt
bankid_pin.txt
Dropbox
Familiealbum_2019
Familiealbum_2020
fodselsnummer_kone.txt
nakenbilde_2021.png
sommerkroppen_2018.png
sykdommer_i_familien.txt
testament_pappa.txt
```

"Okei, kanskje ikke dette er riktig sted. La oss gå tilbake og inn i Test_prosjekt-mappen i stedet" sier Jimmy stille til seg selv.

```console
$ cd ../Test_prosjekt
$ ls

app
buildSrc
gradle
gradle.properties
gradlew
gradlew.bat
README.md
settings.gradle.kts
untitled.iml
utils
```

"Et demo-prosjekt - perfekt! La oss starte AI-verktøyet og prøve oss på noen prompts!" sier Jimmy og Dory i kor!

```console
$ opencode
```

## Høres det kjent ut?

Jeg tror ikke eksempelet og historien om Jimmy og Dory er "far-fetched" og så veldig uvanlig. Okei da, det er kanskje ikke så vanlig å ha _så private_ filer på datamaskinen som man bruker på arbeid, men resten av det som skjer tror jeg mange har gjort. Man finner en nettside med installasjonsinstruksjoner, copy-paster en eller annen kommando som tilsynelatende laster ned og installerer et eller annet, og deretter starter man programmet. Da er man liksom i gang.

Men, til hvilken kost? Og hva er det man egentlig godtar og takker ja til, ved installasjon og bruk av slike verktøy? Det er noe av det som bekymrer meg.

OpenCode er superpopulært for tiden og flittig i bruk av mange utviklere verden over. Kanskje bruker du det selv? Uansett, vet du hvilke innstillinger og rettigheter du godtar og bruker, hvis du følger samme fremgangsmåte som Jimmy og Dory? La oss se på et lite utsnitt av standardinnstillingene til OpenCode. La meg være klinkende klar - dette er _default_. 

```json
{
  ...
  "autoupdate": true,
  "permissions": {
    "read": "allow",
    "edit": "allow",
    "bash": "allow"
  },
  ...
}
```

Er det bare meg som syns at dette skurrer? Ikke bare godtar du automatiske oppdateringer, som når som helst kan endre på innstillingene og hva AI'en får lov til og ikke uten at du får det med deg. Du godtar også at AI'en kan lese, endre og slette filer, samt at AI'en kan kjøre et hvilket som helst bash script. Alt dette uten din godkjenning.

Dette er som sagt standardinnstillingene. Dette er det du får og godtar med mindre du _aktivt endrer det selv_. Sikkerhet har liksom blitt opt-in sånn plutselig. At det er noe vi selv må be om. Det bekymrer meg. AI'en kan som sagt lese, endre og slette _alt_ som du også kan gjøre, da du nettopp har installert dette verktøyet som _deg selv_ og kjører det som _deg selv_.

Her har du noen kontrollspørsmål, som egentlig er best practice uansett om du bruker AI eller ikke, men som kanskje er spesielt viktige i disse dager:
- Har du private filer eller dokumenter, eller annen sensitiv informasjon, som ikke skal havne ut på Internett?
- Har du private nøkler, API-tokens eller andre typer credentials lagret ukryptert i klartekst i en eller annen fil?
- Har du skrudd på automatisk låsing av passordhåndteringsverktøyet ditt, slik at du må taste passord eller identifisere deg når et passord skal hentes ut?
- Har du gode backup-rutiner, som hjelper deg hvis du skulle ha behov for det?
- Har du oversikt over hva og hvilke tilganger du gir verktøyene og programmene dine?

Kort fortalt: har du kontroll i egne sysaker?

Vi snakker om kraftige, ikke-deterministiske og rimelig avanserte verktøy her. Blir vi blendet av de potensielle superkreftene disse verktøyene gir oss og det at alle rundt deg roper "du må komme i gang *nå*!", at vi ikke klarer å vurdere konsekvensene og risikoen ved valgene vi tar?

Jeg sier ikke dette bare for å skremme og være ekkel. Jeg sier ikke dette for at du ikke skal bruke AI. Jeg sier dette for at du skal være mer bevisst. Jeg sier dette fordi vi må være ansvarlige og vite hvilken risiko vi tar. Jeg sier dette fordi jeg bryr meg.

Det siste jeg ønsker er at du må sende følgende e-post:

```txt
Excuse me, mr Big Boss from large AI company,
but your AI just deleted my entire home directory and fucked up my computer.
Could you help me please?
``` 

Det er så mye fokus på hvilken AI-modell du bruker, hvor mange agenter du kjører i parallell, og hvilke skills du tok i bruk i går. Det er fint å flott det, og morsomt å høre om alle erfaringene. Men vær så snill folkens, ikke glem sikkerheten og at det ikke skal så mye til for å gjøre alt dette på en adskillig tryggere måte. 

La oss finne fram sølvfoliehatten og se hvor lett det er å putte AI'en i en sandkasse med begrensede tilganger 🔒

## Docker - perfekt for AI!

"En Docker-container er et *isolert miljø* som inneholder alt nødvendig for å kjøre en applikasjon, inkludert kode, avhengigheter, biblioteker og konfigurasjoner."

Dette er jo akkurat det vi trenger! Vi kan putte AI'en i en lukket sandkasse, hvor det er vi som er i førersetet og bestemmer hvilke filer og verktøy som er tilgjengelig i det isolerte miljøet.

Hvis du nå er en som tenker "hvorfor Docker, og ikke f.eks. Podman?". Vel, godt spørsmål, da Podman er enda bedre med tanke på sikkerhet. Podman er designet for å ikke kjøre som _root_ som standard, så dette får du gratis med på kjøpet! Jeg vil uansett påstå at Docker, med tilhørende tooling, er mer utbredt og "kjent" rundt om enn Podman. I hvert fall der jeg har jobbet. Og poenget jeg vil få fram forblir det samme - nemlig at vi pakker AI'en inn i en sandkasse med begrensede rettigheter og tilganger.

Anyway, hvis du ikke allerede har installert Docker (eller Podman) må du først gjøre det. Følg instruksjonene på nettsidene til f.eks. [Docker - Get Started](https://www.docker.com/get-started/), eller be din allerede-installerte-AI-som-enn-så-lenge-kjører-som-deg-med-dine-rettigheter-og-tilganger-venn om hjelp 🤷‍♂️ 😂

Det neste vi trenger er en `Dockerfile` med beskrivelse og oppsett av det vi trenger for å putte AI'en i en lukket sandkasse og isolert miljø. Nedenfor finner du et utkast du kan bruke som Dockerfile. Btw, alt dette finner du også på Github --> [https://github.com/vegardga/docker-ai](https://github.com/vegardga/docker-ai)

```yaml
# Generisk Dockerfile for å kjøre AI-verktøy i isolerte miljø

# Bytt til ønsket image
FROM ubuntu:24.04

# Unngå unødvendige prompts under installasjon
ENV DEBIAN_FRONTEND=noninteractive

# Oppgrader og installer et utvalg nødvendige og hendige verktøy
# Andre nyttige eksempler: build-essential, openssh-client, sudo, htop, iputils-ping, ..
RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  git \
  unzip \
  vim \
  jq \
  tree \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Opprett en ikke-root-bruker, kalt batman
RUN useradd --create-home --shell /bin/bash batman

# Bytt til "batman" og endre arbeidsmappen til hjem-mappen
USER batman
WORKDIR /home/batman

# Installer OpenCode gjennom offisiell installasjonsscript
RUN curl -fsSL https://opencode.ai/install | bash

# Opprett opencode-mappe for eventuelle konfigurasjonsfiler
RUN mkdir -p /home/batman/.config/opencode

# Default oppstartskommando
CMD ["/bin/bash"]
```

Dette er som sagt et _utgangspunkt_, og ikke vær redd for å endre dette! Bytt image hvis du trenger. Legg til eller fjerne toolingen som blir installert. Lag en egen Dockerfile for backend, og en annen for frontend. Tilpass til ditt bruk og dine behov. Men behold gjerne det med batman, da batman er kul og at du unngår å kjøre som _root_ i containeren 🦇

Resten av konfigurasjon og filer som AI'en trenger for å fungere kan du "mounte inn" når du lager Docker-containere. Her ble det litt mange fremmedord kanskje, så la oss se på et eksempel.

Eksempel-scenario:
- Jimmy har klonet ned et git-repo som han aktivt jobber med lokalt på maskinen sin. Jimmy vil gjerne kjøre tre agenter i parallell, samtidig som han selv jobber med en fjerde oppgave. For å få dette til bruker Jimmy "git worktrees", slik at hver enkelt agent ikke går i beina på hverandre, ei heller med det Jimmy selv vil jobbe med. Hvert enkelt worktree er en kopi av kildekoden, som igjen blir til en egen container basert på imaget fra Dockerfilen beskrevet ovenfor. Jimmy gir containerne kun tilgang til sitt eget worktree og vil på den måten skjerme og gjøre alle andre filer på datamaskinen utilgjenglig for AI'en.

Hørtes dette komplisert ut? Hvis du tidligere har brukt Claude Code eller andre AI-verktøy så er det basically slik disse verktøyene fungerer. Bortsett fra det med tilgangsstyringen og hvilke filer som er tilgjengelig for AI'en da. Her begrenser vi det veldig - mens hvis du har installert og bruker slike verktøy direkte har AI'en tilgang til alt du har tilgang til (som ofte er veldig mye, gjerne alt).

Okei, pjuh, la oss ta for oss eksempelet steg for steg og se hvordan vi kan hjelpe Jimmy med denne arbeidsflyten.

### Steg 1 - Lage et base-AI-image fra Dockerfile

Det første Jimmy gjør er å opprette et base-AI-image fra Dockerfilen beskrevet over. Dette er ikke noe vi trenger å gjøre for hver container/oppgave vi vil kjøre, men noe vi gjør én gang og kan gjenbruke.

Jimmy oppretter derfor en fil kalt `Dockerfile` lik eksempelet over, og bygger så et Docker-image fra denne filen.

```console
$ vim Dockerfile
$ docker build -t base-ai .
```

Det nye imaget er nå tilgjengelig og klar for bruk. Det tar noen sekunder å lage slike image, men senere i flyten når vi skal bruke det snakker vi millisekunder. Det er det verdt for økt sikkerhet :thumbsup: Etter at kommandoen er ferdigkjørt kan du sjekke om imaget er tilgjengelig:

```console
$ docker image ls | grep base-ai
```

### Steg 2 - Egne worktrees per oppgave

Jimmy navigerer seg inn i git-repoet, og oppretter så egne worktrees for de tre ulike oppgavene han vil at AI'en skal jobbe med.

```console
$ cd Test_prosjekt
$ git worktree add -b feature-a ./worktree/feature-a
$ git worktree add -b feature-b ./worktree/feature-b
$ git worktree add -b feature-c ./worktree/feature-c
```

Du kan [lese mer om worktrees her](https://git-scm.com/docs/git-worktree), men kort fortalt vil dette medføre tre ulike mapper i mappen `.worktree` med hver sin kopi av kildekoden og egen git-branch.

```console
$ ls .worktree/

feature-a
feature-b
feature-c
```

### Steg 3 - Egne AI-containere per oppgave

Neste Jimmy nå må gjøre er å opprette og kjøre egne AI-containere for hvert worktree han har opprettet. Dette gjør han ved å taste følgende inn i terminalen:

```console
$ NAME=feature-a; \
  docker run -itd --name=$NAME \
  -v $(pwd)/.worktree/$NAME:/home/batman/workspace \
  base-ai
```

Skulle Jimmy en dag lage sine egne konfigurasjonsfiler med oppsett han vil dele på tvers av alle AI-containerne, kan han enkelt utvide kommandoen med flere filer inn i sandkassen. F.eks:

```console
$ NAME=feature-a; \
  docker run -itd --name=$NAME \
  -v $(pwd)/.worktree/$NAME:/home/batman/workspace \
  -v $HOME/.config/opencode/opencode.json:/home/batman/.config/opencode/opencode.json:ro \
  base-ai
```

Hvis Jimmy gjør det samme for de andre worktree'ene, så kan han etterpå sjekke om alle containere kjører og er klare for bruk.

```console
$ docker ps

CONTAINER ID   IMAGE     COMMAND       CREATED              STATUS              PORTS     NAMES
ad7e22e54725   base-ai   "/bin/bash"   2 seconds ago        Up 1 second                   feature-c
1aaa1e93512a   base-ai   "/bin/bash"   13 seconds ago       Up 12 seconds                 feature-b
31c33fffb74b   base-ai   "/bin/bash"   About a minute ago   Up About a minute             feature-a
```

### Steg 4 - La AI'en koke!

Da har Jimmy opprettet tre AI-containere, som alle er klar for jobb! For å kickstarte AI'en med oppgaven den skal løse går Jimmy inn i den respektive AI-containeren og starter OpenCode.

```console
$ docker exec -it feature-a /bin/bash
batman@31c33fffb74b:~$ cd workspace/
batman@31c33fffb74b:~/workspace$ opencode
```

Skjermbildet under viser det Jimmy nå ser på skjermen sin - AI'en er klar for action, og Jimmy kan sette i gang med en fyldig spørring, med nok kontekst, og la AI'en koke!

## Safety first

That's it. En veldig lik flyt som mange allerede er kjent med og bruker, men samtidig så veldig annerledes også. Forskjellen _is in the details_. I stedet for at man _by default_ kjører AI-verktøy som seg selv, med potensielt tilgang til altfor mye, gir denne fremgangsmåten deg adskillig mer trygghet og sikkerhet uten at det nødvendigvis koster deg fart og flyt.

Du velger selv hva du gjør videre - men jeg ber deg tenke deg nøye om rundt hva du installerer og hva du gir tilgang til. Det er som sagt kraftige og ikke-deterministiske verktøy du tar i bruk - og med det følger det stort ansvar i et hav av muligheter. Ha det gøy, lek og lær, men bruk hodet!

"With great power comes great responsibility", var det noen som sa en gang. Ikke glem det siste der.
