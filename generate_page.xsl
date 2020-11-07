<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match = "results">
		<html>
			<head>

				<link rel="stylesheet" href="style.css"/>
				<title>TP XML</title>
			</head>
			<body>
				<header>
					<nav>
						<div class="logo-container">
								<a href="weather_page.html" target=""/>
								<img  src="./images/logo.jpg" alt="logo"/> 
							</div>
						<ul class= "nav-links">
							
							<li > <a class= "nav-link" href="./extra/diez.html">¿Por qué deberíamos sacarnos un diez Redondo?</a></li>
							<li > <a class= "nav-link" href="./extra/nosotros">Nosotros</a></li>
						</ul>
					</nav>
				</header>
				<h1>Weather status on <xsl:value-of select="count(//city)"/>  cities around the world</h1>
				<xsl:for-each select = "//country">
					<h2>Weather on 
					<xsl:value-of select="count(./cities/city)"/><xsl:choose>
  																	<xsl:when test="count(./cities/city)>1">
  																		&#160;cities in &#160;
  																	</xsl:when>
  																		<xsl:otherwise>&#160;city in&#160; </xsl:otherwise>
  																	</xsl:choose> 
  				 	<xsl:value-of select="./name/text()"/>
  				 	</h2>
				<table >
					<tr>
						<th>City</th>
						<th>Temperature</th>
						<th>Feels Like</th>
						<th>Humidity</th>
						<th>Pressure</th>
						<th>Clouds</th>
						<th>Weather</th>
					</tr>
					<tbody>
						<xsl:for-each select = ".//city">
							<tr>
								<td><xsl:value-of select = "./name"/></td>
								<td><xsl:value-of select = "./temperature"/>&#160;<xsl:value-of select = "./temperature/@unit"/></td>
								<td><xsl:value-of select = "./feels_like"/>&#160;<xsl:value-of select = "./feels_like/@unit"/></td>
								<td><xsl:value-of select = "./humidity"/><xsl:value-of select = "./humidity/@unit"/></td>
								<td><xsl:value-of select = "./pressure"/>&#160;<xsl:value-of select = "./pressure/@unit"/></td>
								<td><xsl:value-of select = "./clouds"/></td>
								<td><xsl:value-of select = "./weather"/>&#160;<img ><xsl:attribute name="src">./images/icons/<xsl:value-of select="./weather/@icon"/>.png</xsl:attribute></img></td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</xsl:for-each>
			</body>
		</html>
	</xsl:template>	
</xsl:stylesheet>