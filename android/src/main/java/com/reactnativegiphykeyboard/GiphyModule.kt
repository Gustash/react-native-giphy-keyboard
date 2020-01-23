package com.reactnativegiphykeyboard

import com.facebook.react.ReactActivity
import com.facebook.react.bridge.*
import com.facebook.react.modules.core.DeviceEventManagerModule.RCTDeviceEventEmitter
import com.giphy.sdk.core.models.Media
import com.giphy.sdk.core.models.enums.RenditionType
import com.giphy.sdk.ui.GPHContentType
import com.giphy.sdk.ui.GPHSettings
import com.giphy.sdk.ui.GiphyCoreUI
import com.giphy.sdk.ui.themes.DarkTheme
import com.giphy.sdk.ui.themes.GridType
import com.giphy.sdk.ui.themes.LightTheme
import com.giphy.sdk.ui.utils.imageWithRenditionType
import com.giphy.sdk.ui.views.GPHMediaView
import com.giphy.sdk.ui.views.GiphyDialogFragment

/* Events */
private const val MEDIA_SELECTED_EVENT = "mediaSelected"
private const val GIPHY_DISMISSED_EVENT = "giphyDismissed"

/** Default Options */
private const val DEFAULT_RENDITION = "original"
private const val DEFAULT_FILE_TYPE = "mp4"
private const val DEFAULT_GRID_TYPE = "waterfall"

class GiphyModule(private val reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext), GiphyDialogFragment.GifSelectionListener {
    private var giphyDialog: GiphyDialogFragment? = null
    private var rendition = DEFAULT_RENDITION
    private var fileType = DEFAULT_FILE_TYPE

    override fun initialize() {
        super.initialize()

        GiphyCoreUI.configure(reactContext, "dm5YT4Vg8bCM0VkDyYAEhTGCAYGyL8L4")
    }

    override fun getName(): String {
        return "RNGiphyKeyboard"
    }

    @ReactMethod
    fun openGiphy(options: ReadableMap) {
        val activity = reactContext.currentActivity as? ReactActivity

        if (activity != null) {
            rendition = getOptionIfSet(options, "rendition") as? String ?: DEFAULT_RENDITION
            fileType = getOptionIfSet(options, "fileType") as? String ?: DEFAULT_FILE_TYPE

            val gridType = getOptionIfSet(options, "gridType") as? String ?: DEFAULT_GRID_TYPE
            val theme = getOptionIfSet(options, "theme") as? String
            val mediaTypes = (getOptionIfSet(options, "mediaTypes") as? ReadableArray)?.toArrayList()
            val filteredMediaTypes = mediaTypes?.filterIsInstance<String>() ?: listOf()

            val settings = GPHSettings()
            if (filteredMediaTypes.isNotEmpty()) {
                settings.mediaTypeConfig = filteredMediaTypes.map {
                    when (it) {
                        "gifs" -> GPHContentType.gif
                        "stickers" -> GPHContentType.sticker
                        "emoji" -> GPHContentType.emoji
                        "text" -> GPHContentType.text
                        else -> null
                    }
                }.filterIsInstance<GPHContentType>().toTypedArray()
            }
            settings.gridType = GridType.valueOf(gridType)
            settings.theme = when (theme) {
                "dark" -> DarkTheme
                else -> LightTheme
            }

            val giphyDialog = GiphyDialogFragment.newInstance(settings)
            giphyDialog.show(activity.supportFragmentManager, "giphy_dialog")
            giphyDialog.gifSelectionListener = this

            this.giphyDialog = giphyDialog
        }
    }

    @ReactMethod
    fun dismissGiphy() {
        giphyDialog?.dismiss()
    }

    override fun onGifSelected(media: Media) {
        val body = Arguments.createMap()
        val image = media.imageWithRenditionType(RenditionType.valueOf(rendition)) ?: return
        val aspectRatio = image.width / image.height.toDouble()
        val url = when (fileType) {
            "mp4" -> image.mp4Url
            "gif" -> image.gifUrl
            "webp" -> image.webPUrl
            else -> ""
        }
        body.putString("url", url)
        body.putInt("width", image.width)
        body.putInt("height", image.height)
        body.putDouble("aspectRatio", aspectRatio)


        sendEvent(MEDIA_SELECTED_EVENT, body)
    }

    override fun onDismissed() {
        rendition = DEFAULT_RENDITION
        fileType = DEFAULT_FILE_TYPE
        giphyDialog = null

        sendEvent(GIPHY_DISMISSED_EVENT)
    }

    private fun sendEvent(event: String, data: Any? = null) {
        reactContext.getJSModule(RCTDeviceEventEmitter::class.java).emit(event, data)
    }

    private fun getOptionIfSet(options: ReadableMap, option: String): Any? {
        if (!options.hasKey(option)) return null

        val value = options.getDynamic(option)

        return when (value.type.name) {
            "String" -> value.asString()
            "Array" -> value.asArray()
            else -> null
        }
    }
}
