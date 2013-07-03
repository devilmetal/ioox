xquery version "1.0";

(: -----------------------------------------------
   ioox controller

   Author: Carnevale Luca & Luyet Gil / UNIFR
   ----------------------------------------------- :)

declare namespace site = "http://oppidoc.com/oppidum/site";
declare namespace request = "http://exist-db.org/xquery/request";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";
declare namespace session = "http://exist-db.org/xquery/session";

import module namespace oppidum = "http://oppidoc.com/oppidum/util" at "../oppidum/lib/util.xqm";
import module namespace epilogue = "http://oppidoc.com/oppidum/epilogue" at "../oppidum/lib/epilogue.xqm";
import module namespace skin = "http://oppidoc.com/oppidum/skin" at "../oppidum/lib/skin.xqm";

declare option exist:serialize "method=xhtml media-type=text/html indent=yes";
(:     doctype-public=-//W3C//DTD&#160;XHTML&#160;1.1//EN
     doctype-system=http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"; :)

(: ======================================================================
   Typeswitch function
   -------------------
   Plug all the <site:{module}> functions here and define them below
   ======================================================================
:)
declare function site:branch( $cmd as element(), $source as element(), $view as element()* ) as node()*
{
 typeswitch($source)
 case element(site:skin) return site:skin($cmd, $view)
 case element(site:login) return site:login($cmd)
 case element(site:home) return site:home($cmd, $view)
 case element(site:menu) return site:menu($cmd, $view)
 case element(site:error) return site:error($cmd, $view)
 case element(site:message) return site:message($view)
 case element(site:image) return site:image($source)
 default return $view/*[local-name(.) = local-name($source)]/*
 (: default treatment to implicitly manage other modules :)
};

(: ======================================================================
   Converts <site:image> static image link
   FIXME: rewrite img-link
   ======================================================================
:)
declare function site:image($image as element()) as element()*
{
  epilogue:img-link('ioox', concat('images/', $image/@src), (), ())
};

(: ======================================================================
   Inserts CSS links and JS scripts to the page
   selection is defined by the current mesh, the optional skin attribute
   of the site:view element, and the site's 'skin.xml' resource
   ======================================================================
:)
declare function site:skin( $cmd as element(), $view as element() ) as node()*
{
  (
  skin:gen-skin('ioox', oppidum:get-resource($cmd)/@epilogue, $view/@skin),
  if (empty($view/site:links)) then () else skin:rewrite-css-link('ioox', $view/site:links)
  )
};

(: ======================================================================
   Handles <site:login> LOGIN banner
   ======================================================================
:)
declare function site:login( $cmd as element() ) as element()*
{
 let
   $uri := request:get-uri(),
   $user := xdb:get-current-user()
   (:   $is-admin := ($user = 'admin') or (xdb:get-user-groups($user)[. = 'site-admin']);:)
 return
   if ($user = 'guest')  then
     if (not(ends-with($uri, '/login'))) then
     
       <header>
                <div class="navbar navbar-fixed-top">
                    <div class="navbar-inner">
                        <div class="container-fluid">
                            <a class="brand" href="#">
                            <img src="{$cmd/@base-url}static/ioox/img/gCons/connections-white.png" alt=""/>
                            Klakxon</a>
                            <ul class="nav user_menu pull-right">
                                <li class="divider-vertical hidden-phone hidden-tablet"></li>
                                <li class="dropdown">
                                    <a class="login" href="{$cmd/@base-url}login?url={$uri}">Login</a>
                                </li>
                            </ul>
                            <ul class="nav" id="mobile-nav">
								<li class="dropdown">
									<a data-toggle="dropdown" class="dropdown-toggle" href="#"><i class="icon-list-alt icon-white"></i> Unifr <b class="caret"></b></a>
									<ul class="dropdown-menu">
										<li><a href="http://www.unifr.ch">Home</a></li>
										<li><a href="http://gestens.unifr.ch">Gestens</a></li>
										<li><a href="http://moodle2.unifr.ch">Moodle 2</a></li>
									</ul>
								</li>
								<li>
								</li>
							</ul>
                        </div>
                    </div>
                </div>
            </header>
     else
       ()
   else
    (
    <header>
                <div class="navbar navbar-fixed-top">
                    <div class="navbar-inner">
                        <div class="container-fluid">
                            <a class="brand" href="#">
                            <img src="{$cmd/@base-url}static/ioox/img/gCons/connections-white.png" alt=""/>
                            Klaxon</a>
                            <ul class="nav user_menu pull-right">
                                <li class="divider-vertical hidden-phone hidden-tablet"></li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">{$user} <b class="caret"></b></a>
                                    <ul class="dropdown-menu">
                                    <li><a href="#">My Profile</a></li>
                                    <li class="divider"></li>
                                    <li><a class="login" href="{$cmd/@base-url}logout?url={$cmd/@base-url}">Log Out</a></li>
                                    </ul>
                                </li>
                            </ul>
                            <ul class="nav" id="mobile-nav">
								<li class="dropdown">
									<a data-toggle="dropdown" class="dropdown-toggle" href="#"><i class="icon-list-alt icon-white"></i> Unifr <b class="caret"></b></a>
									<ul class="dropdown-menu">
										<li><a href="http://www.unifr.ch">Home</a></li>
										<li><a href="http://gestens.unifr.ch">Gestens</a></li>
										<li><a href="http://moodle2.unifr.ch">Moodle 2</a></li>
									</ul>
								</li>
								<li>
								</li>
							</ul>
                        </div>
                    </div>
                </div>
            </header>
    
    
    )
};

(: ======================================================================
   Generates error essages in <site:error>
   ======================================================================
:)
declare function site:error( $cmd as element(), $view as element() ) as node()*
{
  oppidum:render-errors($cmd/@db, $cmd/@lang)
};

(: ======================================================================
   Generates information messages in <site:message>
   Be careful to call session:invalidate() to clear the flash after logout
   redirection !
   TODO: store messages in a database
   ======================================================================
:)
declare function site:message( $view as element() ) as node()*
{
 (: attribute class { 'active' },:)
 for $e in oppidum:get-messages()
 let $type := substring-before($e, ':'), $object := substring-after($e, ':')
 return
   if ($type = 'ACTION-LOGIN-SUCCESS') then
     <p>Vous avez été identifié en tant que "<span>{$object}</span>"</p>
   else if ($type = 'ACTION-LOGOUT-SUCCESS') then
     (
     session:invalidate(),
     <p>Vous avez été déconnecté avec succès</p>
     )
   else if ($type = 'ACTION-UPDATE-SUCCESS') then
     <p>La ressource a été enregistrée avec succès</p>
   else
     ()
};

(: ======================================================================
   Handles <site:home> basic trail
   Displays Home on any page other than the /home page
   ======================================================================
:)
declare function site:home( $cmd as element(), $view as element() ) as element()*
{
  if ($cmd/@trail != 'home') then
    <a href="{concat($cmd/@base-url, 'home')}">Home</a>
  else
    ()
};

(: ======================================================================
   Generates <site:navigation> navigation menu
   Creates one entry for each page in the '/db/sites/ioox' collection
   Adds a button if the user has the right to create extra pages
   ======================================================================
:)


declare function site:menu( $cmd as element(), $view as element() ) as element()*
{
    let $rights := tokenize(request:get-attribute('oppidum.rights'), ' ')
    return 
    <span>
    
            
    <!-- sidebar -->
            <a href="javascript:void(0)" class="sidebar_switch on_switch ttip_r" title="Hide Sidebar">Sidebar switch</a>
            <div class="sidebar">
				<div class="antiScroll">
					<div class="antiscroll-inner">
						<div class="antiscroll-content">
							<div class="sidebar_inner">
								
								<div class="globalmenu">
								<ul class="gmul">
								
								    <li class="gitem">
								    <a href="home" >
										<img src="{$cmd/@base-url}static/ioox/img/gCons/home.png" alt="" /> Home
								    </a>
								    </li>
								
								
								    <li class="gitem">
								    <a href="explorer" >
										<img src="{$cmd/@base-url}static/ioox/img/gCons/search.png" alt="" /> Explorer
								    </a>
								    </li>
								
								
								    <li class="gitem">
								    <a href="faq" >
										<img src="{$cmd/@base-url}static/ioox/img/gCons/push-pin.png" alt="" /> FAQ
									</a>
									</li>
								
								</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
         </span>
};

declare function site:change( $cmd as element(), $view as element() ) as element()*
{
    let $rights := tokenize(request:get-attribute('oppidum.rights'), ' ')
    return
    ()
};
(: ======================================================================
   Recursive rendering function
   ----------------------------
   Copy this function as is inside your epilogue to render a mesh
   ======================================================================
:)
declare function local:render( $cmd as element(), $source as element(), $view as element()* ) as element()
{
  element { node-name($source) }
  {
    $source/@*,
    for $child in $source/node()
    return
      if ($child instance of text()) then
        $child
      else
        (: FIXME: hard-coded 'site:' prefix we should better use namespace-uri :)
        if (starts-with(xs:string(node-name($child)), 'site:')) then
          (
            if (($child/@force) or
                ($view/*[local-name(.) = local-name($child)])) then
                 site:branch($cmd, $child, $view)
            else
              ()
          )
        else if ($child/*) then
          if ($child/@condition) then
          let $go :=
            if (string($child/@condition) = 'has-error') then
              oppidum:has-error()
            else if (string($child/@condition) = 'has-message') then
              oppidum:has-message()
            else if ($view/*[local-name(.) = substring-after($child/@condition, ':')]) then
                true()
            else
              false()
          return
            if ($go) then
              local:render($cmd, $child, $view)
            else
              ()
        else
           local:render($cmd, $child, $view)
        else
         $child
  }
};

(: ======================================================================
   Epilogue entry point
   --------------------
   Copy this code as is inside your epilogue
   ======================================================================
:)
let $mesh := epilogue:finalize()
return
  if ($mesh) then
    local:render(request:get-attribute('oppidum.command'), $mesh, request:get-data())
  else
    ()
