FROM python:3.6.8-stretch

LABEL "version"="1.0.0"
LABEL "repository"="https://github.com/NyanKiyoshi/actions-diff"
LABEL "homepage"="https://github.com/NyanKiyoshi/actions-diff"
LABEL "maintainer"="NyanKiyoshi <hello@vanille.bid>"

LABEL "com.github.actions.name"="GitHub Actions Diff Checker"
LABEL "com.github.actions.description"="Ensures a given file is up to date in comparison from rebuilding it."
LABEL "com.github.actions.icon"="hexagon"
LABEL "com.github.actions.color"="purple"

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY LICENSE README.md entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "--help" ]
