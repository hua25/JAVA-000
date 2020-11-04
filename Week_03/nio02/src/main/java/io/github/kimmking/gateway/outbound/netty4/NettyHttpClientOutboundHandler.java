package io.github.kimmking.gateway.outbound.netty4;

import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelFutureListener;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.handler.codec.http.*;

import static io.netty.handler.codec.http.HttpResponseStatus.NO_CONTENT;
import static io.netty.handler.codec.http.HttpResponseStatus.OK;
import static io.netty.handler.codec.http.HttpVersion.HTTP_1_1;

public class NettyHttpClientOutboundHandler extends ChannelInboundHandlerAdapter {


    private final FullHttpRequest serverFullRequest;
    private final ChannelHandlerContext serverCtx;

    public NettyHttpClientOutboundHandler(FullHttpRequest serverFullRequest, ChannelHandlerContext serverCtx) {
        this.serverFullRequest = serverFullRequest;
        this.serverCtx = serverCtx;
    }

    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg)
            throws Exception {
        if (msg instanceof HttpContent) {
            HttpContent content = (HttpContent) msg;
            ByteBuf resultByteBuf = content.content();
            String data = resultByteBuf.toString(io.netty.util.CharsetUtil.UTF_8);

            FullHttpResponse response = null;
            try {
                response = new DefaultFullHttpResponse(HTTP_1_1, OK, resultByteBuf);
                response.headers().set("Content-Type", "application/json");
                response.headers().setInt("Content-Length", resultByteBuf.capacity());

            } catch (Exception e) {
                e.printStackTrace();
                response = new DefaultFullHttpResponse(HTTP_1_1, NO_CONTENT);
                exceptionCaught(serverCtx, e);
            } finally {
                if (serverFullRequest != null) {
                    if (!HttpUtil.isKeepAlive(serverFullRequest)) {
                        serverCtx.write(response).addListener(ChannelFutureListener.CLOSE);
                    } else {
                        serverCtx.write(response);
                    }
                }
                serverCtx.flush();
            }

        }


    }
}