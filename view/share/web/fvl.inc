[% IF form.has_error %]
<div id="fvl">
<ul>
[% FOREACH e IN form.error_message %]
    <li>[% IF e.value %][% e.value %][% ELSE %][% e.key %][% END %]</li>
[% END %]
</ul>
</div>
[% END %]
