FROM docker.io/elixir:alpine as build_stage

RUN mkdir /buildroot
COPY . /buildroot
WORKDIR /buildroot

RUN mix deps.get --no-archives-check --check-locked --only
RUN mix escript.build

FROM docker.io/elixir:alpine as release_stage

COPY --from=build_stage /buildroot/decompilerl /decompilerl

ENTRYPOINT ["/decompilerl"]
