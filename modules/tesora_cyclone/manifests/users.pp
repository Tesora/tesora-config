# == Class: tesora_cyclone::users
#
class tesora_cyclone::users {
  @user::virtual::localuser { 'andrew':
    realname => 'Andrew Bramley',
    sshkeys  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDjbp4bWniYVvYowg/CWZRHx2q0qIPdOWdpJp+xmPHSbLHBcTnmGzpZPlCL6RwQm0KsoXFq5fIdHXdw457zxFYlsEYs0xrahXfijWgAqrq4tT06z12qv5i/W+8GPb/5X8T+yiswHGTIAYKc0Z2U7GUD6/E++1oFkHwvbrbmbDEmccApcx+HPNx22CZHa+JG7uTY80HZK5ulEPFbGMokapk76Un+oSjF3E13sKKQUZR2cLo1vrDrvdlc3y03+JAsXZ5jWEBe7ZpXmnX7k5xBSvLX+JwuN00FKNyPKbawLsOeoPLuanSis4xlnc1S1/fIMa3iuHGtUbXPM7JXq3fEWhVeruiMPpoL/nKXEP9NY+prtRwXPA2PLFB/GRM0GoFZWSBPxhf5s4LgJh/cnSRMlrZyNvoo7y76aeUqxG+bvr4TwOvT6D1n9GFo4AjYfQ748TvmWDY3kGMx4012jLNGeAQ++ao56KRgf1tQ9i3BrDUsu+O63HKLYHZiI+XVGl1LTXJamD2haYz3v0jPpEAKAjfweCqtwMh+G1+1x0mB4Gr+GF5CD5tjDhRmuThThgkDQVFn75O+JBut3EnaNUckLSQjwrcuXVS8wqW27Zou6H01Jpkaw7mg/ez7F3b5AQmUfRcd4smBFM28ZMOZSR0E/3GUIRXRkNl87d0oTVV4iM+L/Q==',
    key_id   => 'andrew@tesora.com',
  }

  @user::virtual::localuser { 'amrith':
    realname => 'Amrith Kumar',
    sshkeys  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCxnJUutDKMEbJYuAPe/BA+0P3dvglUAIzKbMWpNcg++/G5iGwqkrXO6IXddCVvu5MTTd6T266XNL7EVIljc6ZE3FS8O4GCPUWqnnFf57+pXCMAmRTEo35ybuMXYfsdxhRArXm3rg4BSGX8QruW5Hai/Rn6yB10/aDsTGD+1DI2uZf3eGltFFIhTLj/sEYTsthNwkz4EXXPz46sBrITxEd3zDExxmI478dQq2FD1/EOo4MLW+1VRK4V5g7uaq3eHWmEEQRhdQQ6/lGd1x4zXXqHJQFRq2dGDazzJJ9cI4T3nWrCrveTM+pmv+uFIDFY9xK19Z2Srj1gfr2gQtdV+eWD',
    key_id   => 'amrith@tesora.com',
  }

  @user::virtual::localuser { 'bhunter':
    realname => 'Brian Hunter',
    sshkeys  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC03xWgnO2+v4EDn8jajgkUg4+X8iDOvD9c62h8qxqKNY35sefrtFkbUdPWxj1i6zW+X7+dDOuAM5ZtVhmVc0X+t6J6b4igZy1gmtdm4ca560SBa0kVs2tBGLLXmCOoSEA9N/32/LgPq5ggmAehyDkKaZxTUxmIvkZnaxynv8XUrBmfapTupLZ/3E24ysj/1ood4/buIOe9gpei6r1iMGkT2CNcW9SRg54N0NDG40y+R1BDMLdQSqiUf6Ov7A+U5clDtB5piqPKt4Wj2ckXPWFcKQ0TAvY+tX9u/M2dzUwq6Sqd4LqKcG2Tk3hxP/bC3KZz3XLkf5mpAFdawCWfxSLf',
    key_id   => 'bhunter@tesora.com',
  }

  @user::virtual::localuser { 'doug':
    realname => 'Doug Shelley',
    sshkeys  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDC4HL4EsY0QB/b4ATDPpAbvWIq6iP/YNWRwlEgOrZeE2nJ0K27RrLZDE0diyySyRE2bFeIy3ILX21aycNR7mYRmLMJb6nMZ7RUz2J76Xp2FayuPuXCoESxXQO0aL/3yUVNPYHkF3Ux3q2FWxPF1OAN1kJMBWGmY/XlFYskR6DMp650H8Wz056tPdgrlnanY0nAoEKD793wAsQ1x0wpzqd1tq4A/bvqLKEy6wcvc+WnXmPYkyL7y9tDY7Tk61Il4lusHKJ/Xjn2PxZr/pyySqfBtrr3gmB45zuv238G/kyCDh3/MH4IPpihKi0iXclba9CcjqBr43HG+keui9+birMZ',
    key_id   => 'doug@tesora.com',
  }


}
