declare variable $lat external;
declare variable $long external;
declare variable $cnt external;

declare variable $long-empty := "The longitud parameter is empty.";
declare variable $lat-empty := "The latitud parameter is empty.";
declare variable $cnt-empty := "The cnt parameter is empty.";

declare variable $long-invalid := "The longitud parameter is invalid.";
declare variable $lat-invalid := "The latitud parameter is invalid.";
declare variable $cnt-invalid := "The cnt parameter is invalid.";

declare variable $long-not-a-number := "The longitud parameter is not a number.";
declare variable $lat-not-a-number := "The latitud parameter is not a number.";
declare variable $cnt-not-a-number := "The cnt parameter is not a number.";

declare function local:is-a-number ( $value as xs:anyAtomicType? )  as xs:boolean
{
	string(fn:number($value)) != 'NaN'
} ;

declare function local:is_empty() as xs:boolean
{
	not($long) or not($lat) or not($cnt)
};

declare function local:is_invalid_long($param) as xs:boolean
{
	fn:number($param) > 180 or fn:number($param) < -180
};

declare function local:is_invalid_lat($param) as xs:boolean
{
	fn:number($param) > 90 or fn:number($param) < -90
};

declare function local:is_invalid_cnt($param) as xs:boolean
{
	fn:number($param) > 50 or fn:number($param) < 1
};

declare function local:is_invalid_parameters() as xs:boolean
{
	local:is_invalid_long($long) or local:is_invalid_lat($lat) or local:is_invalid_cnt($cnt) or	not(local:is-a-number($long)) or not(local:is-a-number($lat)) or not(local:is-a-number($cnt))
};

if(local:is_empty() or local:is_invalid_parameters())
then(
	<results>

	{if(not($lat))
	then(<error>{$lat-empty}</error>)
	else()}
	{if(not($long))
	then(<error>{$long-empty}</error>)
	else()}
	{if(not($cnt))
	then(<error>{$cnt-empty}</error>)
	else()}

	{if(not(local:is-a-number($lat)))
	then(<error>{$lat-not-a-number}</error>)
	else()}
	{if(not(local:is-a-number($long)))
	then(<error>{$long-not-a-number}</error>)
	else()}
	{if(not(local:is-a-number($cnt)))
	then(<error>{$cnt-not-a-number}</error>)
	else()}

	{if(local:is_invalid_long($long))
	then(<error>{$long-invalid}</error>)
	else()}
	{if(local:is_invalid_lat($lat))
	then(<error>{$lat-invalid}</error>)
	else()}
	{if(local:is_invalid_cnt($cnt))
	then(<error>{$cnt-invalid}</error>)
	else()}

	</results>
	)
else (
	<results xsi:noNamespaceSchemaLocation="weather_data.xsd">
	{
	let $data := doc("data.xml")//item
	for $country in distinct-values($data//country/string())
	return
		<country alpha-2= "{$country}">
			<name>{doc("countries.xml")//country[@alpha-2 = $country]/@name/string()}</name>
			<cities>
			{
				for $elem in $data[./city/country/string() = $country]
				return
					<city>
						<name>{$elem/city/@name/string()}</name>
						<temperature unit ="{$elem/temperature/@unit}">{xs:float($elem/temperature/@value)}</temperature>
						<feels_like unit ="{$elem/feels_like/@unit}">{xs:float($elem/feels_like/@value)}</feels_like>
						<humidity unit ="{$elem/humidity/@unit}">{round(number($elem/humidity/@value))}</humidity>
						<pressure unit ="{$elem/pressure/@unit}">{round(number($elem/pressure/@value))}</pressure>
						<clouds>{$elem/clouds/@name/string()}</clouds>
						<weather icon="{$elem/weather/@icon}">{$elem/weather/@value/string()}</weather>
					</city>
			}
			</cities>
		</country>
	}
	</results>
)
