---
title: Encryption Side Effect
layout: post
description: "Something really cool"
category:
tags: [ ]
---

We finally worked auto-encrypting certain sections of our `web.config` into our build scripts. Nothing is particularly exciting about this, except for the side effect that puzzled  me for a while.

We're encrypting using `aspnet_regiis.exe` like many other people probably are.

    aspnet_regiis -pe "connectionStrings" -app "/MyApplication" -prov "MyProvider"

This all works fine and dandy, but after doing so, our redirects stopped working. This makes no sense, but the following section of the web.config is missing.

    :::xml
    <system.webServer>
	<rewrite>
	    <rules>
            <rule name="Redirect HTTP to HTTPS"
                  stopProcessing="true"
                  enabled="#{redirect_to_https}">
            <match url="(.*)"/>
            <conditions>
              <add input="{HTTPS}" pattern="^OFF$"/>
            </conditions>
            <action type="Redirect" url="https://{HTTP_HOST}/{R:1}" redirectType="SeeOther"/>
          </rule>
        </rules>
      </rewrite>
    </system.webServer>

Huh? Every time we run the encryption, this section disappears.

Turns out, we had another `system.webServer` section in the `web.config` somewhere. That section remained and this one was _cleaned up_. Combining these sections works just fine.

Surprisingly, the redirects actually worked before. IIS must find both sections and read them both. I imagine there might be cases were other `web.config` sections go missing after running that encryption statement.
