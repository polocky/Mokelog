<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
<title></title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<link rel="home" href="" title="" />
<link rel="help" href="" title="" />
<link rel="icon" type="image/x-icon" href="/img/favicon.ico" />
<link rel="Shortcut Icon" type="img/x-icon" href="/img/favicon.ico" />
<link rel="stylesheet" type="text/css" href="/static/wiki/css/cpan-like.css" />
<link rel="stylesheet" type="text/css" href="/static/css/style.css" />
<script type="text/javascript" src=""></script>

</head>
<body>
<div id="container">

[% IF project_obj %]
<div id="header">
<div id="global-header"><a href="/">モケログ「プロジェクト見守るくん」</a></div>
[% IF c.req.user %]
<div id="login"><span>[% c.req.user %]ちゃん</span></div>
[% ELSE %]
<div id="login"><a href="/cms/">ログイン</a></div>
[% END %]
<div id="site-title">
<h1>[% project_obj.title | html %]</h1>
[% project_obj.sexy_description %]
</div><!-- /site-title -->
</div><!-- /header -->
[% ELSE %]
<div id="header">
[% IF c.req.user %]
<div id="login"><span>[% c.req.user %]ちゃん</span></div>
[% ELSE %]
<div id="login"><a href="/cms/">ログイン</a></div>
[% END %]
<div id="site-title">
<h1>モケログ「プロジェクト見守るくん」</h1>
<p>いま進めている仕事の出来事をちゃくちゃくと記録していくお手伝いします</p>
</div><!-- /site-title -->
</div><!-- /header -->
[% END %]


<div id="content">
