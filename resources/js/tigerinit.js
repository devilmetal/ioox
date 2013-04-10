var form;
function init() {
form = new xtiger.util.Form('../bundles');
form.setTemplateSource(document);
form.enableTabGroupNavigation();
if (! form.transform()) { alert(this .form.msg); }
}
xtdom.addEventListener(window, 'load', init, false);
