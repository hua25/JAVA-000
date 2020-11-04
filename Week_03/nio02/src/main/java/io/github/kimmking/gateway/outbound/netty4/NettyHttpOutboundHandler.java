package io.github.kimmking.gateway.outbound.netty4;

import io.github.kimmking.gateway.outbound.OutBoundHandler;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.http.FullHttpRequest;

import java.net.URI;

public class NettyHttpOutboundHandler implements OutBoundHandler {

    private final String backendUrl;
    private final String backendIp;
    private final int backendPort;

    public NettyHttpOutboundHandler(String backendUrl) {
        this.backendUrl = backendUrl.endsWith("/") ? backendUrl.substring(0, backendUrl.length() - 1) : backendUrl;
        String[] tempArr = backendUrl.split(":");
        URI uri = URI.create(backendUrl);
        this.backendIp = uri.getHost();
        this.backendPort = uri.getPort();
    }

    @Override
    public void handle(FullHttpRequest fullRequest, ChannelHandlerContext ctx) {
        final String url = this.backendUrl + fullRequest.uri();
        NettyHttpClient client = new NettyHttpClient(backendIp, backendPort);
        try {
            client.execute(url, fullRequest,ctx);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
