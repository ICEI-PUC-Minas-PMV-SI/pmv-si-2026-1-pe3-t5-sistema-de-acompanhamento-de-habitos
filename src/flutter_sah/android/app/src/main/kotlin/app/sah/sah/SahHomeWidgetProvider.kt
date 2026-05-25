package app.sah.sah

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import org.json.JSONArray
import org.json.JSONObject

class SahHomeWidgetProvider : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: android.content.SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.sah_home_widget)

            val payloadStr = widgetData.getString("today_payload", null)

            if (payloadStr == null) {
                renderEmpty(views, "Abra o app para começar")
            } else {
                try {
                    val payload = JSONObject(payloadStr)
                    val count = payload.optString("count", "")
                    val hasAny = payload.optBoolean("has_any", false)
                    val habits: JSONArray = payload.optJSONArray("habits") ?: JSONArray()

                    views.setTextViewText(R.id.widget_count, count)

                    if (!hasAny) {
                        renderEmpty(views, context.getString(R.string.sah_widget_empty))
                    } else if (habits.length() == 0) {
                        renderEmpty(views, "Tudo certo hoje ✓")
                    } else {
                        views.setViewVisibility(R.id.widget_empty, View.GONE)
                        val rowIds = arrayOf(R.id.row_1, R.id.row_2, R.id.row_3)
                        val nameIds = arrayOf(R.id.name_1, R.id.name_2, R.id.name_3)
                        val dotIds = arrayOf(R.id.dot_1, R.id.dot_2, R.id.dot_3)
                        for (i in 0 until 3) {
                            if (i < habits.length()) {
                                val h = habits.getJSONObject(i)
                                views.setViewVisibility(rowIds[i], View.VISIBLE)
                                views.setTextViewText(nameIds[i], h.optString("nome", ""))
                                val done = h.optBoolean("done", false)
                                views.setImageViewResource(
                                    dotIds[i],
                                    if (done) R.drawable.widget_dot_done else R.drawable.widget_dot_pending
                                )
                            } else {
                                views.setViewVisibility(rowIds[i], View.GONE)
                            }
                        }
                    }
                } catch (e: Exception) {
                    renderEmpty(views, context.getString(R.string.sah_widget_empty))
                }
            }

            val openAppIntent = Intent(context, MainActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
            }
            val pendingIntent = PendingIntent.getActivity(
                context,
                0,
                openAppIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.widget_root, pendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }

    private fun renderEmpty(views: RemoteViews, message: String) {
        views.setViewVisibility(R.id.row_1, View.GONE)
        views.setViewVisibility(R.id.row_2, View.GONE)
        views.setViewVisibility(R.id.row_3, View.GONE)
        views.setViewVisibility(R.id.widget_empty, View.VISIBLE)
        views.setTextViewText(R.id.widget_empty, message)
    }
}
