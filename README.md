# Synology Download Station - Bash Interface

## Requirements:

- curl
- jq

## add magnet URL schema handler

add url shema handler to `Contents/info.plist`

```
<key>CFBundleURLTypes</key>
<array>
	<dict>
		<key>CFBundleURLName</key>
		<string>Magnet URL</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>magnet</string>
		</array>
	</dict>
</array>
```

