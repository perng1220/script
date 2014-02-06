#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin
export webpath=/var/www/html

function get_idsite() {
	idsite=`mysql -h 192.168.0.89 --user=piwik --password=123456 -e "use piwik;select idsite from piwik_site where main_url='http://web$i.test.com'"`
	if [ -z "$idsite" ]; then
		echo "idsite not exist"
		exit
	fi	

}

function create_website() {
	mkdir -p $webpath/web$i
	cat > test.txt <<-EOF
		<html>
		<head><title></title></head>
		<!-- Piwik --> 
		<script type="text/javascript">
		var pkBaseURL = (("https:" == document.location.protocol) ? "https://piwik.test.com/" : "http://piwik.test.com/");
		document.write(unescape("%3Cscript src='" + pkBaseURL + "piwik.js' type='text/javascript'%3E%3C/script%3E"));
		</script><script type="text/javascript">
		try {
		var piwikTracker = Piwik.getTracker(pkBaseURL + "piwik.php", $idsite);
		piwikTracker.trackPageView();
		piwikTracker.enableLinkTracking();
		} catch( err ) {}
		</script><noscript><p><img src="http://piwik.test.com/piwik.php?idsite=$idsite" style="border:0" alt="" /></p></noscript>
		<!-- End Piwik Tracking Code -->
		<body>
		web
		</body>
		</html>

	EOF
}

for (( i=1; i<=2; i++ ))
do
	if [ -d "$webpath/web$i" ]; then
		echo "Directory $webpath/web$i exist"
		exit
	fi
	elinks "http://piwik.test.com/?module=API&method=SitesManager.addSite&siteName=web$i&urls=web$i.test.com&&token_auth=7917f2596f8bb70c954893f200ba6274" > /dev/null 2&>1
	get_idsite
	create_website
done
