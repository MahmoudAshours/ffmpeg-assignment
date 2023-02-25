import 'dart:html' as html;

String bytesToUrl(bytes) {
  final blob = html.Blob([bytes]);
  return html.Url.createObjectUrlFromBlob(blob);
}
