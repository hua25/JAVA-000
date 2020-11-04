package io.github.kimmking.gateway.outbound.netty4;

import io.netty.bootstrap.Bootstrap;
import io.netty.channel.*;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioSocketChannel;
import io.netty.handler.codec.http.*;

import java.net.URI;

public class NettyHttpClient {
    private final String ip;
    private final int port;

    public NettyHttpClient(String backendIp, int backendPort) {
        this.ip = backendIp;
        this.port = backendPort;
    }

    public void execute(String url, FullHttpRequest serverFullRequest, ChannelHandlerContext serverCtx) throws Exception {
        EventLoopGroup workerGroup = new NioEventLoopGroup();

        try {
            Bootstrap b = new Bootstrap();
            b.group(workerGroup);
            b.channel(NioSocketChannel.class);
            b.option(ChannelOption.SO_KEEPALIVE, true);
            b.handler(new ChannelInitializer<SocketChannel>() {
                @Override
                public void initChannel(SocketChannel ch) throws Exception {
                    // 客户端接收到的是httpResponse响应，所以要使用HttpResponseDecoder进行解码
                    ch.pipeline().addLast(new HttpResponseDecoder());
//                     客户端发送的是httprequest，所以要使用HttpRequestEncoder进行编码
                    ch.pipeline().addLast(new HttpRequestEncoder());
                    ch.pipeline().addLast(new NettyHttpClientOutboundHandler(serverFullRequest,serverCtx));
                }
            });
            ChannelFuture f = b.connect(ip, port).sync();

            URI uri = new URI(url);
            FullHttpRequest request = new DefaultFullHttpRequest(HttpVersion.HTTP_1_0, HttpMethod.GET, uri.toASCIIString());
            request.headers()
//                .set(HttpHeaderNames.CONTENT_TYPE, "text/plain;charset=UTF-8")
                    //开启长连接
//                .set(HttpHeaderNames.CONNECTION, HttpHeaderValues.KEEP_ALIVE)
                    //设置传递请求内容的长度
                    .set(HttpHeaderNames.CONTENT_LENGTH, request.content().readableBytes());

            //发送数据
            f.channel().write(request);
            f.channel().flush();
            f.channel().closeFuture().sync();
        } finally {
            workerGroup.shutdownGracefully();
        }

    }

}