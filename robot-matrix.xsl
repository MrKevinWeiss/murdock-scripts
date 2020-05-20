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
      <div><p/></div>
      <div class="row mx-auto justify-content-center">
        <img class="d-block" src="https://ci.riot-os.org/static/logo.png" alt="" height="90" />
        <h2 class="display-2">HIL Testing Results</h2>
      </div> <!-- row -->
      <div class="row justify-content-around">
	<p><span class="badge badge-info">Click on the progress bars to get detailed results</span></p>
      </div> <!-- row -->
      <div class="row">
        <xsl:apply-templates select="//boards" />
      </div> <!-- row -->
      </div> <!-- container -->
    </body>
  </html>
</xsl:template>

<xsl:template match="boards">
  <table class="table table-hover">
    <thead class="thead-light">
      <tr>
        <th class="border-right">Board</th>
        <xsl:for-each select="board[@name = 'samr21-xpro']/testsuite">
        <th><xsl:value-of select="@name" /></th>
        </xsl:for-each>
      </tr> 
    </thead>
    <tbody>
      <xsl:for-each select="board">
      <tr>
        <th class="border-right" scope="row">
        <xsl:value-of select="@name" />
        </th>
        <xsl:for-each select="testsuite">
          <xsl:variable name="board" select="../@name"/>
          <xsl:variable name="suite" select="translate(@name,' ','_')"/>
          <xsl:variable name="pass" select="@tests - @failures"/>
          <xsl:variable name="total" select="@tests"/>
          <xsl:variable name="percent" select="$pass div $total * 100"/>
          <td>
            <a class="card-link" href="{$board}/{$suite}/report.html">
              <div class="progress bg-danger position-relative">
                <div class="progress-bar bg-success" role="progressbar" style="width: {$percent}%" aria-valuenow="{$percent}" aria-valuemin="0" aria-valuemax="100" /> 
                <bold class="justify-content-center d-flex position-absolute w-100 text-light">(<xsl:value-of select="$pass" />/<xsl:value-of select="$total" />)</bold>
              </div>
            </a>
          </td>
        </xsl:for-each>
      </tr>
      </xsl:for-each>
    </tbody>
  </table> 
</xsl:template>

</xsl:stylesheet>
