;;; mql-mode.el --- Simple major mode for editing mql files

;; Copyright (C) 2016 Matúš Goljer <matus.goljer@gmail.com>

;; Author: Matúš Goljer <matus.goljer@gmail.com>
;; Maintainer: Matúš Goljer <matus.goljer@gmail.com>
;; Version: 0.0.1
;; Created: 31st May 2016
;; Keywords: conf

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Major mode for editing mql files: https://www.mql4.com/

;;; Code:

(require 'cc-mode)

;;;###autoload (add-to-list 'auto-mode-alist '("\\.mq4\\'" . mql-mode))

;;;###autoload
(define-derived-mode mql-mode c++-mode "Mql"
  "Major mode for Mql files.")

(provide 'mql-mode)
;;; mql-mode.el ends here
