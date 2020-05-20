<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

<xsl:template match="/">
  <html lang="en">
    <head>
      <!-- Required meta tags -->
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

      <!-- Bootstrap CSS -->
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous" />
      <title>RIOT HIL</title>
    </head>
    <body>
      <!-- Optional JavaScript -->
      <!-- jQuery first, then Popper.js, then Bootstrap JS -->
      <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
      <div class="container">
      <div class="row justify-content-around">
        <h1 class="display-2">RIOT HIL Testing Results</h1>
      </div> <!-- row -->
      <xsl:apply-templates/>
      </div> <!-- container -->
    </body>
  </html>
</xsl:template>

<xsl:template match="boards">
  <div class="row justify-content-around">
  <xsl:apply-templates/>
  </div> <!-- row -->
</xsl:template>

<xsl:template match="board">
  <div class="col-4">
    <div class="card shadow">
      <div class="card-header">
    	<xsl:value-of select="@name"/>
      </div>
      <!--
      <img class="card-img-top" src="..." alt="Card image cap"/>
      -->
      <ul class="list-group">
      <xsl:apply-templates/>
      </ul>
    </div>
  </div> <!-- col -->
</xsl:template>

<xsl:template match="testsuite">
  <xsl:variable name="board" select="../@name"/>
  <xsl:variable name="suite" select="translate(@name,' ','_')"/>
  <li class="list-group-item">
    <span><a class="card-link" href="{$board}/{$suite}/report.html"><xsl:value-of select="@name"/></a></span>
    <div class="progress bg-danger">
      <xsl:variable name="pass" select="@tests - @failures"/>
      <xsl:variable name="total" select="@tests"/>
      <xsl:variable name="percent" select="$pass div $total * 100"/>
      <div class="progress-bar bg-success" role="progressbar" style="width: {$percent}%" aria-valuenow="{$percent}" aria-valuemin="0" aria-valuemax="100"> </div>
    </div>
  </li>
</xsl:template>

</xsl:stylesheet>
