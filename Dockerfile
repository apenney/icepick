FROM msaraiva/erlang:18.1

RUN apk --update add erlang-crypto erlang-sasl && rm -rf /var/cache/apk/*

ADD icepick /usr/local/bin/icepick

ENTRYPOINT ["/usr/local/bin/icepick"]
