<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="no"/>

    <xsl:param name="xslt.rights"/>
    <xsl:param name="xslt.base-url">/</xsl:param>
    <xsl:template match="/">
        <site:view>
            <site:xtiger>
                <link href="/exist/projets/ioox/css" rel="stylesheet" type="text/css"/>
            </site:xtiger>
            <site:content>

                <div class="row-fluid">
                    <h1>Haha !</h1>
                    <p>Test !</p>
                </div>
            </site:content>


            <site:javascript>
                <script src="/exist/projets/ioox/static/ioox/js/jquery.min.js" type="text/javascript">//</script>
                <script src="/exist/projets/ioox/static/ioox/js/jquery-migrate.min.js" type="text/javascript">//</script>
                <script src="/exist/projets/ioox/static/ioox/js/jquery.debouncedresize.min.js" type="text/javascript">//</script>
                <script src="/exist/projets/ioox/static/ioox/js/jquery.actual.min.js" type="text/javascript">//</script>
                <script src="/exist/projets/ioox/static/ioox/js/jquery_cookie.min.js" type="text/javascript">//</script>
                <script src="/exist/projets/ioox/static/ioox/js/bootstrap.min.js" type="text/javascript">//</script>
                <script src="/exist/projets/ioox/static/ioox/js/bootstrap.plugins.min.js" type="text/javascript">//</script>
                <script src="/exist/projets/ioox/static/ioox/js/jquery.qtip.min.js" type="text/javascript">//</script>
                <script src="/exist/projets/ioox/static/ioox/js/jquery.jBreadCrumb.1.1.min.js" type="text/javascript">//</script>
                <script src="/exist/projets/ioox/static/ioox/js/ios-orientationchange-fix.js" type="text/javascript">//</script>
                <script src="/exist/projets/ioox/static/ioox/js/antiscroll.js" type="text/javascript">//</script>
                <script src="/exist/projets/ioox/static/ioox/js/jquery-mousewheel.js" type="text/javascript">//</script>
                <script src="/exist/projets/ioox/static/ioox/js/jquery.colorbox.min.js" type="text/javascript">//</script>
                <script src="/exist/projets/ioox/static/ioox/js/selectNav.js" type="text/javascript">//</script>
                <script src="/exist/projets/ioox/static/ioox/js/gebo_common.js" type="text/javascript">//</script>
                <script src="/exist/projets/ioox/static/ioox/js/gebo_btns.js" type="text/javascript">//</script>
                <script>
                    $(document).ready(function() {
                    setTimeout('$("html").removeClass("js")',1000);
                    });
                </script>
            </site:javascript>
        </site:view>
    </xsl:template>
</xsl:stylesheet>
