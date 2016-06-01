import std.datetime;
import vibe.appmain;
import vibe.http.server;
import vibe.stream.tls;
import vibe.stream.botan;
import vibe.core.log;
import vibe.core.core;
import libasync.threads;
import memutils.unique;
import botan.rng.auto_rng;
import botan.tls.session_manager;


import policies;

void handleRequest(scope HTTPServerRequest req, scope HTTPServerResponse res)
{
    res.writeBody("Hello, World!", "text/plain");
}

void main(string[] args)
{
    setLogLevel(LogLevel.trace);
    auto settings = new HTTPServerSettings;
    settings.port = 8090;
    settings.bindAddresses = ["::1", "0.0.0.0"];
    auto policy = new FasterTLSPolicy();


    Unique!AutoSeededRNG rng = new AutoSeededRNG;
    auto tls_sess_man = new TLSSessionManagerInMemory(*rng);

    settings.tlsContext = new BotanTLSContext(TLSContextKind.server, null, policy, tls_sess_man);
    settings.tlsContext.useCertificateChainFile("server.crt");
    settings.tlsContext.usePrivateKeyFile("server.key");

    listenHTTP(settings, &handleRequest);
    runEventLoop();
}
