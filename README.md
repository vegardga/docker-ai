# docker-ai

Putt AI'en i en sandkasse

## Dockerfile for AI

Ikke kjør AI'en som "deg selv", med dine rettigheter og tilganger. Kjør AI'en trygt og sikkert i en Docker-container, hvor det er du som er i førersetet og har full kontroll over hvilke filer og tilganger du tillater.

Hent inspirasjon fra `Dockerfile`, og tilpass til dine behov. Dette er som sagt et _utgangspunkt_, og ikke vær redd for å endre! Bytt image hvis du trenger. Legg til eller fjerne toolingen som blir installert. Lag en egen Dockerfile for backend, og en annen for frontend. Tilpass til ditt bruk og dine behov.

Men behold gjerne det med batman, da batman er kul og at du unngår å kjøre som _root_ i containeren.

Bygg base-ai-image:

```
$ docker build -t base-ai .
```


Det nye imaget er nå tilgjengelig og klar for bruk. Det tar noen sekunder å lage slike image, men senere når vi skal bruke det snakker vi millisekunder. Det er det verdt for økt sikkerhet. Etter at kommandoen er ferdigkjørt kan du sjekke om imaget er tilgjengelig:

```
$ docker image ls | grep base-ai
```

## Opprett egne AI-containere ved behov

AI-imaget du nettopp lagde kan gjenbrukes. Start egne AI-containere ved behov, og mat inn filene som du bestemmer.

```
$ docker run -itd --name=ai-feature-x \
  -v /full/sti/til/filene/du/vil/inkludere:/home/batman/workspace \
  base-ai
```

Filene/mappene du dytter inn i Docker-containeren trenger den fulle stien. Et mer eksplisitt eksempel, der jeg allerede har navigert meg inn i git-repoet til prosjektet jeg vil teste med AI. Her har jeg allerede opprettet et eget git-worktree kalt "feature-a", så ikke AI'en jobber på de samme filene som eventuelt jeg jobber med.

```
$ NAME=feature-a; \
  docker run -itd --name=$NAME \
  -v $(pwd)/.worktree/$NAME:/home/batman/workspace \
  -v $HOME/.config/opencode/opencode.json:/home/batman/.config/opencode/opencode.json:ro \
  base-ai
```

I tillegg ser du at jeg har "mountet inn" OpenCode-innstillinger og egen konfigurasjon. Det er som nevnt du som bestemmer hvilke filer som skal være tilgjengelig, og som må inkluderes inn i containeren.

Ved å legge til `:ro` kan du også bestemme at disse filene kun er lesbar, og kan da ikke endres.

## Koble deg på og start AI'en!

Etter at Dockerfile er bygd, AI-container er opprettet og kjører i bakgrunnen, kan du koble deg på og sette i gang AI'en.

```
$ docker exec -it feature-a /bin/bash
batman@31c33fffb74b:~$ cd workspace/
batman@31c33fffb74b:~/workspace$ opencode
```

## Oneliner

Hvis dette er noe du ofte gjør og har bruk for - hvorfor ikke legge det inn som en alias du enkelt kan kjøre? Hent inspirasjon fra denne onlineren og lag din egen alias.

```
$ NAME=feature-x; \
    docker run -itd --name=$NAME \
    -v $(pwd):/home/batman/workspace \
    -v $HOME/.config/opencode/config/opencode.json:/home/batman/.config/opencode/opencode.json:ro \
    -v $HOME/.config/opencode/config/auth.json:/home/batman/.local/share/opencode/auth.json:ro \
    base-ai \
    && docker exec -it $NAME /bin/bash
```

## Safety first

Stay safe - happy AI-coding! 
